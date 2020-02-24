namespace Quantum.Grover {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;

    
    /// # Summary
    /// This operation applies Grover's algorithm to search all possible inputs
    /// to an operation to find a particular marked state.
    operation SearchForMarkedInput(nQubits : Int) : Result[] {
        using (qubits = Qubit[nQubits]) {
            // Initialize a uniform superposition over all possible inputs.
            PrepareUniform(qubits);
            // The search itself consists of repeatedly reflecting about the
            // marked state and our start state, which we can write out in Q#
            // as a for loop.
            for (idxIteration in 0..NIterations(nQubits) - 1) {
                ReflectAboutMarked(qubits);
                ReflectAboutUniform(qubits);
            }
            // Measure and return the answer.
            return ForEach(MResetZ, qubits);
            // ForEach operation :
            // Given an array and an operation that is defined for the elements of the array, 
            // returns a new array that consists of the images of the original array under the operation.

            // MResetZ operation :
            // Measures a single qubit in the Z basis, 
            // and resets it to the standard basis state |0〉 following the measurement.
        }
    }

    /// # Summary
    /// Returns the number of Grover iterations needed to find a single marked
    /// item, given the number of qubits in a register.
    function NIterations(nQubits : Int) : Int {
        let nItems = 1 <<< nQubits; // 2^numQubits
        // compute number of iterations:
        let angle = ArcSin(1. / Sqrt(IntAsDouble(nItems)));
        let nIterations = Round(0.25 * PI() / angle - 0.5);
        // Round function : Rounds a value to the nearest integer.
        return nIterations;
    }


}
