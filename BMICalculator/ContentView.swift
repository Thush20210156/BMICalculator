//
//  ContentView.swift
//  BMICalculator
//
//  Created by Thushini Abeysuriya on 2024-10-13.
//

import SwiftUI

struct BMICalculation: Identifiable {
    let id = UUID()
    let date: Date
    let bmi: Double
    let percentageChange: Double?
    let bmiCategory: String
}

struct ContentView: View {
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var bmi: Double = 0.0
    @State private var bmiCategory: String = ""
    @State private var showAlert: Bool = false
    @State private var selectedDate: Date = Date()
    
    @State private var bmiRecords: [BMICalculation] = []
    
    var body: some View {
        ZStack {
            // Background Color
            Color(.systemTeal)
                .ignoresSafeArea()

            VStack {
                Text("BMI Calculator")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.top, 150)
                    .padding(.bottom, 20)
                
                // Weight Input with a single border around label and TextField, separated by vertical line
                HStack {
                    Text("Weight (kg):")
                        .foregroundColor(.indigo)
                        .fontWeight(.bold)
                        .frame(minWidth: 5, alignment: .leading)
                    
                    Divider()
                        .frame(width: 3 ,height: 30)
                        .background(Color.gray)
                    
                    TextField("Enter weight (kg)", text: $weight)
                        .fontWeight(.bold)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.leading, 10)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3)
                )
                .padding()
                
                // Height Input with a single border around label and TextField, separated by vertical line
                HStack {
                    Text("Height (m):")
                        .foregroundColor(.indigo)
                        .fontWeight(.bold)
                        .frame(minWidth: 5, alignment: .leading)
                    
                    Divider()
                        .frame(width: 3,height: 30)
                        .background(Color.gray)
                    
                    TextField("Enter height (m)", text: $height)
                        .fontWeight(.bold)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(.leading, 10)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 3)
                )
                .padding()
                
                // Date Picker to set the date
                DatePicker("Select Date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .padding()
                    //.background(Color.white)
                    .fontWeight(.bold)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                    .padding(.horizontal)

                // Calculate Button
                Button(action: calculateBMI) {
                    Text("Calculate BMI")
                        .font(.headline)
                        .padding()
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Invalid Input"), message: Text("Please enter valid numeric values for weight and height."), dismissButton: .default(Text("OK")))
                }
                
                // Display BMI Result
                if bmi > 0 {
                    Text("Your BMI: \(String(format: "%.2f", bmi))")
                        .font(.title2)
                        .padding()
                    
                    Text("Category: \(bmiCategory)")
                        .font(.title3)
                        .padding()
                }
                
                // Title for the BMI records section
                if !bmiRecords.isEmpty {
                    Text("BMI Records")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 20)
                }

                // Scrollable List of BMI Records
                ScrollView {
                    ForEach(bmiRecords) { record in
                        VStack(alignment: .leading) {
                            Text("Date: \(record.date, formatter: dateFormatter)")
                            Text("BMI: \(String(format: "%.2f", record.bmi))")
                            Text("Category: \(record.bmiCategory)")
                            if let change = record.percentageChange {
                                Text("Change: \(String(format: "%.2f", change))%")
                            }
                        }
                        .padding()
                       
                        .background(Color.yellow)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.horizontal)
                    }
                }
                .frame(height: 250) // Set the height of the scrollable list
                .padding(.top, 1)
                .padding(.bottom, 5)
              
                
                Spacer()
            }
            .padding()
        }
    }
    
    // BMI Calculation Function
    func calculateBMI() {
        guard let weightValue = Double(weight), let heightValue = Double(height), heightValue > 0 else {
            showAlert = true
            return
        }
        
        bmi = weightValue / (heightValue * heightValue)
        determineBMICategory()
        
        // Calculate percentage change if there's a previous record
        let previousBMI = bmiRecords.last?.bmi
        let percentageChange = previousBMI != nil ? ((bmi - previousBMI!) / previousBMI!) * 100 : nil
        
        // Add the new record, including BMI category
        let newRecord = BMICalculation(date: selectedDate, bmi: bmi, percentageChange: percentageChange, bmiCategory: bmiCategory)
        bmiRecords.append(newRecord)
    }
    
    // Determine BMI Category
    func determineBMICategory() {
        switch bmi {
        case ..<18.5:
            bmiCategory = "Underweight"
        case 18.5..<24.9:
            bmiCategory = "Normal weight"
        case 24.9..<29.9:
            bmiCategory = "Overweight"
        default:
            bmiCategory = "Obese"
        }
    }
}

// Date formatter for displaying the date
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()




#Preview {
    ContentView()
}
