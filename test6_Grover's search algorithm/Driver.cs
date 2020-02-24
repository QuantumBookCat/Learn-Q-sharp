using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Grover
{
    class Program
    {
        static void Main(string[] args)
        {
            var sim = new QuantumSimulator();
            var nDatabaseQubits = 5;

            var result = SearchForMarkedInput.Run(sim, nDatabaseQubits).Result;
            Console.WriteLine($"Result: {result}");

            Console.WriteLine("\n\nPress any key to continue...\n\n");
            Console.ReadKey();
        }
    }
}