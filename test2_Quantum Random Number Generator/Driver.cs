﻿using System;
using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;
using System.Linq;

namespace Quantum.QSharpApplication1
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                // First we initialize all the variables:
                var bitString = "0"; // To save the bit string
                int max = 50; // The maximum of the range
                int size = Convert.ToInt32(Math.Floor(Math.Log(max, 2.0) + 1));
                // To calculate the amount of needed bits
                int output = max + 1; // Int to store the output
                while (output > max)  // Loop to generate the number
                {
                    bitString = "0"; // Restart the bit string if fails
                    bitString = String.Join("", Enumerable.Range(0, size).Select(idx =>
                                            QuantumRandomNumberGenerator.Run(qsim).Result == Result.One ? "1" : "0"
                                                                                )
                                           );
                    // Generate and concatenate the bits using using the Q# operation
                    output = Convert.ToInt32(bitString, 2);
                    // Convert the bit string to an integer
                }
                // Print the result
                Console.WriteLine($"The random number generated is {output}.");
            }
        }
    }
}