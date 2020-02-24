namespace Quantum.QSharpApplication1 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;

    operation QuantumRandomNumberGenerator() : Result {
        using(qubit = Qubit())  { // Allocate a qubit.
            H(qubit);             // Put the qubit to superposition. It now has a 50% chance of being 0 or 1.
            let r = M(qubit);     // Measure the qubit value.
            Reset(qubit);
            return r;
        }
    }

}
