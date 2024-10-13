//
//  ContentView.swift
//  BMICalculator
//
//  Created by Thushini Abeysuriya on 2024-10-13.
//

import SwiftUI

struct ContentView: View {
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var bmi: Double = 0.0
    @State private var bmiCategory: String = ""
    
    var body: some View {
        VStack {
            Text("BMI Calculator")
                .font(.largeTitle)
                .padding()
            
            // Weight Input
            HStack {
                Text("Weight (kg):")
                TextField("Enter weight", text: $weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            // Height Input
            HStack {
                Text("Height (m):")
                TextField("Enter height", text: $height)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()
            
            // Calculate Button
            Button(action: calculateBMI) {
                Text("Calculate BMI")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            // Display BMI Result
            if bmi > 0 {
                Text("Your BMI: \(String(format: "%.2f", bmi))")
                    .font(.title2)
                    .padding()
                
                Text("Category: \(bmiCategory)")
                    .font(.title3)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
    }
    
    // BMI Calculation Function
    func calculateBMI() {
        guard let weight = Double(weight), let height = Double(height), height > 0 else {
            return
        }
        bmi = weight / (height * height)
        determineBMICategory()
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




#Preview {
    ContentView()
}
