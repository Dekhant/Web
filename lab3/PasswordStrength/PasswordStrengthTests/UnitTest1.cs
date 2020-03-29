using Microsoft.VisualStudio.TestTools.UnitTesting;
using PasswordStrength;

namespace PasswordStrengthTests
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void EmptyPassword()
        {
            string[] test1 = new string[1] { "" };
            int result;
            result = Program.Main(test1);
            Assert.AreEqual(1, result);
        }

        [TestMethod]
        public void IncorrectArgumentsQuantity()
        {
            string[] test2 = new string[] { "abcd", "efgh" };
            int result;
            result = Program.Main(test2);
            Assert.AreEqual(1, result);
        }

        [TestMethod]
        public void WrongSymbols()
        {
            string[] test3 = new string[1] { "ab*cd/" };
            int result;
            result = Program.Main(test3);
            Assert.AreEqual(1, result);
        }

        [TestMethod]
        public void NormalWork()
        {
            string[] test4 = new string[] { "abcd1a" };
            int result;
            result = Program.Main(test4);
            Assert.AreEqual(40, result);
        }
    }
}
