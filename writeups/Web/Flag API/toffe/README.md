# Writeup

When starting the container I am greeted with a website that says `no website hosted here`. Looking at the source code I see that it is a simple html page.

```
<html>
    <head></head>
    <body>
        no website hosted here
    </body>
</html>
```

Since we are given the source I can also check around there and I see that there is a [FlagController.cs](website/Controllers/FlagController.cs) file. Looking at that I see that it has a route `api/flag` and that it requires a secret as a `header`. 

```cs
[ApiController]
[Route("api/flag")]
public class FlagController : ControllerBase
{
    
    [HttpGet]
    [Host("localhost:*", "impossible.ept.gg:*")]
    public string GetFlag()
    {
        var secret = Request.Headers["Secret"];
        try{
        var model = new FlagModel();
        return model.GetFlag(secret[0]);
        }catch(Exception e){
            return "This did not work, use the source";
        }

    }
}
```

I also see that it is setup with two hostnames only `localhost`and `impossible.ept.gg`. So trying those with the header `Host` I get the error message `This did not work, use the source`. Now looking at GetFlag function in the [FlagModel.cs](website/Models/FlagModel.cs) which seems to be the function validating my secret.

```cs
public string GetFlag(String key_word) {
    var plainKey = encrypt(Base64Decode(key_word),-13);
    if(plainKey.Equals("eptctforthewin")){
        var flag = File.ReadAllText("flag.txt");
        return flag;
    } else {
        return "This is not a flag, try again";
    }
}
```

Adding a random secret secret I get the other error `This is not a flag, try again`. So next I try to reverse the encrypt function. 

```cs
static string encrypt(string value, int shift) {
    char[] buffer = value.ToCharArray();
    for (int i = 0; i < buffer.Length; i++)
    {
        char letter = buffer[i];
        letter = (char)(letter + shift);
        if (letter > 'z')
        {
            letter = (char)(letter - 26);
        }
        else if (letter < 'a')
        {
            letter = (char)(letter + 26);
        }
        buffer[i] = letter;
    }
    return new string(buffer);
}
```

But after looking at it it looks like a basic rot13 so I open [CyberChef](https://gchq.github.io/CyberChef/#recipe=ROT13(true,true,false,13)To_Base64('A-Za-z0-9%2B/%3D')&input=ZXB0Y3Rmb3J0aGV3aW4) to generate this secret `cmNncGdzYmVndXJqdmE=`.

Throwing that into Curl and I get the flag.

```bash
$ curl -H "Secret: cmNncGdzYmVndXJqdmE=" -H "Host: impossible.ept.gg" http://io.ept.gg:40992/api/flag

EPT{Host_h3aders_ar3_fun_som3tim3}
```