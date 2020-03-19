using System;
using System.Collections.Generic;

namespace remove_duplicates
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("Incorrect number of argumens!");
                Console.WriteLine("Right form: remove_duplicates <input string>");
                return;
            }
            HashSet<char> charset = new HashSet<char>();
            String str = args[0];
            for(int i = 0; i < str.Length; i++)
            {
                if(!charset.Contains(str[i]))
                {
                    charset.Add(str[i]);
                }
                else
                {
                    str = str.Remove(i, 1);
                    i--;
                }
            }
            Console.WriteLine(str);
        }
    }
}
