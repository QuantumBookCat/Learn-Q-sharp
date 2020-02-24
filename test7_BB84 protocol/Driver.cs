using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.BB84
{
    class Driver
    {
        static void Main(string[] args)
        {

            int num = 25;
            var qsim = new QuantumSimulator();
            //BB84Q.Run(qsim, num).Wait();
            var result = BB84Q.Run(qsim, num).Result;
            Console.WriteLine($"Key: {result}");

        }
    }
}