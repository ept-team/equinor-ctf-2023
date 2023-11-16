using System.IO;

namespace FlagApi.Models
{

    public class FlagModel
    {

        public string GetFlag(String key_word)
        {
            var plainKey = encrypt(Base64Decode(key_word),-13);
            if(plainKey.Equals("eptctforthewin")){
                var flag = File.ReadAllText("flag.txt");
                return flag;
            }else{
                return "This is not a flag, try again";
            }
            

        }

        static string encrypt(string value, int shift)
        {
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

        private string Base64Encode(string plainText)
        {
            var plainTextBytes = System.Text.Encoding.UTF8.GetBytes(plainText);
            return System.Convert.ToBase64String(plainTextBytes);
        }

        private string Base64Decode(string base64Text)
        {

            var base64TextBytes = System.Convert.FromBase64String(base64Text);
            return System.Text.Encoding.UTF8.GetString(base64TextBytes);
        }

    }

}