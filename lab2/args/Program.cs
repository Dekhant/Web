using System;

namespace args
{
    class Program
    {
        static void Main(string[] args)
        {
           if(args.Length == 0)
            {
                System.Console.WriteLine("No parameters were specified!");
            }
            else
            {
                System.Console.WriteLine("Number of arguments:" + args.Length);
                System.Console.Write("Arguments: ");
                foreach (string str in args)
                    Console.Write(str + " ");
            }

            return;
        }
    }
}
