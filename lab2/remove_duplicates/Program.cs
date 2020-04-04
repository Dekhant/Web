using System;
using System.Linq;

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
            String str = args[0];
            str = new string(str.Distinct().ToArray());
            Console.WriteLine(str);
        }
    }
}
