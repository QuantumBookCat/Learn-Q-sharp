using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Bell
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    var res = TestBellState.Run(qsim, 1000, initial).Result;
                    //Run the quantum algorithm. 
                    //Each Q# operation generates a C# class with the same name. 
                    //This class has a Run method that asynchronously executes the operation. 
                    //The execution is asynchronous because execution on actual hardware will be asynchronous. 
                    //Because the Run method is asynchronous, we fetch the Result property; 
                    //this blocks execution until the task completes and returns the result synchronously.

                    var (numZeros, numOnes) = res;
                    System.Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");
                }
            }

            System.Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}