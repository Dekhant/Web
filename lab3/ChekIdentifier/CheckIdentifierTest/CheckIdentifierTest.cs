using Microsoft.VisualStudio.TestTools.UnitTesting;
using lab3;

namespace CheckIdentifierTest
{
    [TestClass]
    public class CheckIdentifierTest
    {
        [TestMethod]
        public void WrongBegging()
        {
            string[] test1 = new string[1] { "1abc" };
            int result;
            result = Program.Main(test1);

            Assert.AreEqual(0, result);
        }

        [TestMethod]
        public void IncorrectSymbol()
        {
            string[] test2 = new string[1] { "abc/d" };
            int result;
            result = Program.Main(test2);

            Assert.AreEqual(0, result);
        }

        [TestMethod]
        public void NormalTest()
        {
            string[] test3 = new string[1] { "abcd123" };
            int result;
            result = Program.Main(test3);

            Assert.AreEqual(1, result);
        }

        [TestMethod]
        public void EmptyString()
        {
            string[] test4 = new string[1] { "" };
            int min;
            min = Program.Main(test4);

            Assert.AreEqual(0, min);
        }

        [TestMethod]
        public void IncorrectArgumentsQuantityMore()
        {
            string[] test5 = new string[2] { "abcd", "efg1" };
            int min;
            min = Program.Main(test5);

            Assert.AreEqual(0, min);
        }

        [TestMethod]
        public void IncorrectArgumentsQuantityLess()
        {
            string[] test5 = new string[0] {};
            int min;
            min = Program.Main(test5);

            Assert.AreEqual(0, min);
        }
    }

}
