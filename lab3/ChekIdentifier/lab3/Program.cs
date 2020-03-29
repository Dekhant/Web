using System;
using System.Collections.Generic;
namespace lab3
{
    public class Program
    {
        public static int Main(string[] args)
        {
            if (args.Length != 1)
            {
                Console.WriteLine("Incorrect number of argumens!");
                Console.WriteLine("Right form: CheckIdentifier <input string>");
                return 0;
            }
            String iden = args[0];
            if(iden == "")
            {
                Console.WriteLine("No");
                Console.WriteLine("Identifier cant be empty");
                return 0;
            }
            if (Char.IsDigit(iden[0]))
            {
                Console.WriteLine("No");
                Console.WriteLine("Identifier cant to star with digit");
                return 0;
            }
            for (int i = 0; i < iden.Length; i++)
            {
                if (!((iden[i] >= 'A' && iden[i] <= 'Z') || (iden[i] >= 'a' && iden[i] <= 'z')) && !(Char.IsDigit(iden[i])))
                {
                    Console.WriteLine("No");
                    Console.WriteLine("Identifier cant conteins not english symbols");
                    return 0;
                }
               
            }
            Console.WriteLine("Yes");
            return 1;
        }
    }
}
