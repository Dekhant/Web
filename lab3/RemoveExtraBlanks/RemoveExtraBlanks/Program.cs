using System;
using System.Collections.Generic;
using System.IO;

namespace RemoveExtraBlanks
{
    public class Program
    {
        public static int Main(string[] args)
        {
            if(args.Length != 2)
            {
                System.Console.WriteLine("invalid quantity of parametуrs");
                return 1;
            }
            if (!File.Exists(args[0]))
            {
                System.Console.WriteLine("input file not found");
                return 1;
            }
            StreamWriter outputFile = new StreamWriter(args[1]);
            if (!File.Exists(args[1]))
            {
                System.Console.WriteLine("output file not found");
                return 1;
            }
            string[] allLines = File.ReadAllLines(args[0]);
            foreach (string str in allLines)
            {
                string result = str.Trim();
                result = String.Join(" ", result.Split(new char[] { ' ' }, StringSplitOptions.RemoveEmptyEntries));
                result = String.Join("\t", result.Split(new string[] { "\t" }, StringSplitOptions.RemoveEmptyEntries));
                outputFile.WriteLine(result);
            }
            outputFile.Close();
            return 0;
        }
    }
}
