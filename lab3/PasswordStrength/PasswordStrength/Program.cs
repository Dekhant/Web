using System;
using System.Collections.Generic;

namespace PasswordStrength
{
    public class Program
    {
        public static int Main(string[] args)
        {
            if(args.Length != 1)
            {
                System.Console.WriteLine("invalid quantity of parametуrs");
                return 1;
            }
            if(args[0].Length == 0)
            {
                System.Console.WriteLine("You dont enter the password to check");
                return 1;
            }
            string Password = args[0];
            int Strength = 0, NumbersCounter = 0, UpperLettersCounter = 0, DuplicatesCounter = 0, LowerLettersCounter = 0;
            HashSet<char> charset = new HashSet<char>();
            HashSet<char> duplicates = new HashSet<char>();
            Strength = Password.Length * 4;
            for (int i = 0; i < Password.Length; i++)
            {
                if (!((Password[i] >= 'A' && Password[i] <= 'Z') || (Password[i] >= 'a' && Password[i] <= 'z')) && !(Char.IsDigit(Password[i])))
                {
                    Console.WriteLine("Password can only contains english symbols and numbers");
                    return 1;
                }
                if (Char.IsDigit(Password[i]))
                {
                    NumbersCounter++;
                }
                else
                {
                    if (Password[i] >= 'A' && Password[i] <= 'Z')
                    {
                        UpperLettersCounter++;
                    }
                    else
                    {
                        LowerLettersCounter++;
                    }
                }
                if (!charset.Contains(Password[i]))
                {
                    charset.Add(Password[i]);
                }
                else
                {
                    if (!duplicates.Contains(Password[i]))
                    {
                        duplicates.Add(Password[i]);
                        DuplicatesCounter++;
                    }
                    DuplicatesCounter++;
                }
            }
            Strength += 4 * NumbersCounter;
            Strength += (Password.Length - UpperLettersCounter) * 2;
            Strength += (Password.Length - LowerLettersCounter) * 2;
            if(NumbersCounter == 0 || (LowerLettersCounter + UpperLettersCounter) == 0)
            {
                Strength -= Password.Length;
            }
            Strength -= DuplicatesCounter;
            System.Console.WriteLine(Strength);
            return Strength;
        }
    }
}
