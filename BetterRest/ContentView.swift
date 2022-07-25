//
//  ContentView.swift
//  BetterRest
//
//  Created by Saurabh Jamadagni on 23/07/22.
//

// commented text is from the core implementation iteration created following the tutorial

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUp
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUp: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var bedTime: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let wakeUpComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hours = (wakeUpComponents.hour ?? 0) * 3600 // converting to seconds
            let minutes = (wakeUpComponents.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error!"
            alertMessage = "Sorry, your bedtime couldn't be calculated."
            showingAlert = true
        }
        return "WIP"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("When do you want to wake up?")
                            .font(.headline)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                }
                
                Section {
                    VStack(alignment:.leading) {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                }
                
                Section {
                    VStack(alignment: .leading) {
//                        Text("Daily coffee intake")
//                            .font(.headline)
//
//                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    
                        Picker("Daily coffee intake", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text($0 == 1 ? "\($0) cup" : "\($0) cups")
                            }
                        }
                        .font(.headline)
                    }
                }
                
                Section {
                    Text(bedTime)
                        .font(.largeTitle)
                        .foregroundColor(.green)
                } header: {
                    Text("You should go to bed by")
                }
            }
            .navigationTitle("BetterRest")
//            .toolbar {
//                Button("Calculate", action: calculatePressed)
//            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
//    func calculatePressed() {
//        do {
//            let config = MLModelConfiguration()
//            let model = try SleepCalculator(configuration: config)
//
//            let wakeUpComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
//            let hours = (wakeUpComponents.hour ?? 0) * 3600 // converting to seconds
//            let minutes = (wakeUpComponents.minute ?? 0) * 60
//
//            let prediction = try model.prediction(wake: Double(hours + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
//            let sleepTime = wakeUp - prediction.actualSleep
//
//            alertTitle = "Your ideal bedtime is…"
//            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
//
//        } catch {
//            alertTitle = "Error!"
//            alertMessage = "Sorry, your bedtime couldn't be calculated."
//        }
//
//        showingAlert = true
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
