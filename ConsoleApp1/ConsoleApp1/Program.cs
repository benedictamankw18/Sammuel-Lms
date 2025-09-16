using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BCrypt.Net;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            string hashedPassword = BCrypt.Net.BCrypt.HashPassword("NewPassword123");
            Console.WriteLine(hashedPassword);
            Console.ReadKey();
        }
    }
}
