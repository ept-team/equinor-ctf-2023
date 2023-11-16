using Microsoft.AspNetCore.DataProtection;
using Microsoft.AspNetCore.Mvc;
using System.IO;
using FlagApi.Models;


namespace flagapi.Controllers;

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

