using Microsoft.VisualStudio.TestTools.UnitTesting;
using RemoveExtraBlanks;
using System.IO;

namespace RemoveExtraBlanksTests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void IncorrectArgumentsQuantityLess()
        {
            string[] test1 = { "input.txt" };
            int min;
            min = Program.Main(test1);
            Assert.AreEqual(1, min);
        }

        [TestMethod]
        public void IncorrectArgumentsQuantityMore()
        {
            string[] test2 = { "input.txt", "output.txt", "randomFile.txt" };
            int min;
            min = Program.Main(test2);
            Assert.AreEqual(1, min);
        }

        [TestMethod]
        public void WrongInputFileName()
        {
            string[] test3 = { "input1.txt", "output.txt" };
            int min;
            min = Program.Main(test3);
            Assert.AreEqual(1, min);
        }

        [TestMethod]
        public void WrongOutputFileName()
        {
            string[] test4 = { "input.txt", "output1.txt" };
            int min;
            min = Program.Main(test4);
            Assert.AreEqual(1, min);
        }

        [TestMethod]
        public void NormalWork()
        {
            string[] test5 = { "test3_input.txt", "test3_output.txt" };
            bool same = true;
            Program.Main(test5);
            string[] TestLines = File.ReadAllLines("test3_output.txt");
            string[] TrueLines = File.ReadAllLines("test3_trueoutput.txt");
            for( int i = 0; i < TestLines.Length; i++)
            {
                if(TestLines[i] != TrueLines[i])
                {
                    same = false;
                }
            }
            Assert.AreEqual(true, same);
        }
        [TestMethod]
        public void NothingToDelete() 
        {
            string[] test6 = { "test4_input.txt", "test4_output.txt" };
            bool same = true;
            Program.Main(test6);
            string[] TestLines = File.ReadAllLines("test4_output.txt");
            string[] TrueLines = File.ReadAllLines("test4_input.txt");
            for (int i = 0; i < TestLines.Length; i++)
            {
                if (TestLines[i] != TrueLines[i])
                {
                    same = false;
                }
            }
            Assert.AreEqual(true, same);
        }
    }
}
