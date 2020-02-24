namespace Quantum.Bell {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    
    operation Set(desired : Result, q1 : Qubit) : Unit {  //Unit --> void
        if (desired != M(q1)) {
            X(q1);
        }
    }

    operation TestBellState(count : Int, initial : Result) : (Int, Int) { // return a tuple as a ValueTuple in C#

        mutable numOnes = 0; // "mutable" --> value of variable can be changed by "set"
        using (qubit = Qubit()) {
            // The using statement is used to allocate qubits for use in a block of code. 
            //In Q#, all qubits are dynamically allocated and released, 
            //rather than being fixed resources that are there for the entire lifetime of a complex algorithm. 
            //A using statement allocates a set of qubits at the start, 
            //and releases those qubits at the end of the block.
            
            for (test in 1..count) {
                Set(initial, qubit);
                //X(qubit); ////(add 2.)
                H(qubit); ////(add 3.)
                let res = M(qubit); // "let" --> value of variable cannot be changed

                // Count the number of ones we saw:
                if (res == One) {
                    set numOnes += 1; // "set" --> change value of variable declared by "mutable"
                }
            }
            Set(Zero, qubit);  // reset qubit to Zero because of "using (qubit = Qubit())"
        }

        // Return number of times we saw a |0> and number of times we saw a |1>
        return (count-numOnes, numOnes);
    }

}
