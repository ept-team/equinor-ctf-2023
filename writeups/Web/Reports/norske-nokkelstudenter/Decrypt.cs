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