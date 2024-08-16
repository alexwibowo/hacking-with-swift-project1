//
//  ContentView.swift
//  WeSplit
//
//  Created by Alex Wibowo on 9/8/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    @State var count = 0
    @State var name = ""
    let students = ["Harry", "Hermione", "Ron"]
    @State var selectedStudent = ""
    
    @State var numberOfPeople = 2
    @State var checkAmount = 0.0
    @State var tipPercentage = 0
    
    @FocusState var amountIsFocus
    
    var amountPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount",
                              value: $checkAmount,
                              format: .currency(code: Locale.current.currency?.identifier  ?? "USD")
                    ).keyboardType(.decimalPad)
                        .focused($amountIsFocus) // this will modify amountIsFocus when the textfield is in focus
                    
                    
                    Picker("Number of people",
                           selection: $numberOfPeople) {
                        ForEach(2..<10) {number in
                            Text("\(number) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip") {
                    Picker("Tip percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented) // bullet style
                }
                
                Section {
                    Text(amountPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier  ?? "USD")
                    )
                }
                
                Section {
                    Picker("Select student", selection: $selectedStudent) {
                        ForEach(students, id: \.self ) { student in
                            Text("\(student)")
                        }
                    }
                    ForEach(students, id: \.self ) { number in
                        Text("This is \(number)")
                    }
                }
                
                
                Section {
                    TextField("Enter your name", text: $name)
                    Text("Hello: \(name)")
                    Text("Count is \(count)")
                    Button {
                        count += 1
                    } label: {
                        Text("Increment count")
                    }

                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // becaue amountIsFocus is annotated with FocusState, this view will get re-rendered
                // when it changes. Then we will put the button on the toolbar accordingly.
                if (amountIsFocus){
                    Button("Done") {
                        // toggle the amountIsFocus to false
                        amountIsFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
