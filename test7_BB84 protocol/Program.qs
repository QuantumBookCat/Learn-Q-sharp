namespace Quantum.BB84 {

    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;


    
    operation BB84Q (num : Int) : Int[] {

        // Alice prepares N qubits randomly
        let N = num;
        mutable Alice_array1 = new Int[N];
        mutable Alice_array2 = new Int[N];
        mutable string1 = "";
        mutable string2 = "";
        mutable string3 = "";
    
        for (i in 0..(N - 1)) {
            set Alice_array1 w/= i <- RandomInt(2);
            set Alice_array2 w/= i <- RandomInt(2);

            if (Alice_array1[i] == 0){
                set string1 += "0" ;
			}
            else{
                set string1 += "1" ;
			}

            if (Alice_array2[i] == 0){
                set string2 += "0" ;
			}
            else{
                set string2 += "1" ;
			}

            if (Alice_array1[i] == 0 and Alice_array2[i] == 0){
                set string3 += "0" ;
			}
            elif (Alice_array1[i] == 1 and Alice_array2[i] == 0){
                set string3 += "1" ;
			}
            elif (Alice_array1[i] == 0 and Alice_array2[i] == 1){
                set string3 += "+" ;
			}
            elif (Alice_array1[i] == 1 and Alice_array2[i] == 1){
                set string3 += "-" ;
			}

        }

        Message("Alice :");
        Message("bits");
        Message(string1);
        Message("bases");
        Message(string2);
        Message("generate photons");
        Message(string3);

        // Bob randomly chooses bases
        mutable Bob_array1 = new Int[N];
        mutable string5 = "";

        for (i in 0..(N - 1)) {
            set Bob_array1 w/= i <- RandomInt(2);

            if (Bob_array1[i] == 0){
                set string5 += "Z" ;
			}
            else{
                set string5 += "X" ;
			}
        }

        Message("Bob :");
        Message("bases");
        Message(string5);

        mutable result = new Int[N];

        using (qubits = Qubit[N]) {
            // Alice prepares N qubits randomly
            for (i in 0..(N - 1)) {
                if (Alice_array1[i] == 1){
                    X(qubits[i]);
				}
                if (Alice_array2[i] == 1){
                    H(qubits[i]);
				}
            }
            // Alice sends N qubits to Bob

            // Bob randomly chooses bases to measure
            //mutable Bob_result = new Result[N];

            for (i in 0..(N - 1)) {
                if (Bob_array1[i] == 1){
                    H(qubits[i]); 
				}
                //set Bob_result w/= i <- M(qubits[i]);

                if (M(qubits[i])==Zero){
                    set result w/= i <- 0;
				}
                else{
                    set result w/= i <- 1;
				}
            }

			ResetAll(qubits);
        }

        mutable string_result = "";

        for(i in 0..(N-1)){
            if(result[i]==0){
                set string_result += "0";
			}  
            else{
                set string_result += "1";
			}
		}

        Message("measurement result :");
        Message(string_result);

        // check the same basis
        mutable Alice_key = new Int[N];
        mutable Bob_key = new Int[N];
        mutable count = 0;

        for (i in 0..(N - 1)) {
            if(Alice_array2[i]==Bob_array1[i]){
                set Alice_key w/= i <- Alice_array1[i];
                set Bob_key w/= i <- result[i];
                set count += 1;
			}
            else{
                set Alice_key w/= i <- 8;
                set Bob_key w/= i <- 8;
			}
        }

        mutable string6 = "";
        mutable string7 = "";
    
        for (i in 0..(N - 1)) {
            if (Alice_key[i] == 0){
                set string6 += "0" ;
			}
            elif (Alice_key[i] == 1){
                set string6 += "1" ;
			}

            if (Bob_key[i] == 0){
                set string7 += "0" ;
			}
            elif (Bob_key[i] == 1){
                set string7 += "1" ;
			}

        }

        Message("Alice_key :");
        Message(string6);
        Message("Bob_key :");
        Message(string7);

        // check key bit
        mutable final_key = new Int[0];
        mutable count2 = 0;
        mutable error_count = 0;

        for (i in 0..(N-1)) {
            if(Alice_key[i] != 8){
                set count2 += 1;

                if (count2 <= count/2){
                    if (Alice_key[i] != Bob_key[i]){
                        set error_count += 1;
			    	}
			    }
                else{
                    set final_key += [Alice_key[i]] ;
		    	}
			}
        }

        let error_percentage = IntAsDouble(error_count/(count/2))*100.0;
        let string_error = DoubleAsString(error_percentage)+"%";
        Message(string_error);

        Message("final key :");
        return final_key;

    }
}
