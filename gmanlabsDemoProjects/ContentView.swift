//
//  ContentView.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 30/05/24.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var healthKitManager = HealthKitManager()
    @State private var isAnimating = false
    
    var body: some View {
        NavigationView {
            VStack {
                if let errorMessage = healthKitManager.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    List {
                        HStack {
                            Text("Steps:")
                            Spacer()
                            Text("\(Int(healthKitManager.steps))")
                                .scaleEffect(isAnimating ? 1.1 : 1.0)
                                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                        }
                        HStack {
                            Text("Distance (m):")
                            Spacer()
                            Text(String(format: "%.2f", healthKitManager.distance))
                                .scaleEffect(isAnimating ? 1.1 : 1.0)
                                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                        }
                        HStack {
                            Text("Heart Rates:")
                            Spacer()
                            VStack(alignment: .trailing) {
                                ForEach(healthKitManager.heartRates, id: \.self) { rate in
                                    Text(String(format: "%.2f", rate))
                                }
                            }
                            .scaleEffect(isAnimating ? 1.1 : 1.0)
                            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isAnimating)
                        }
                    }
                }
            }
            .onAppear {
                healthKitManager.requestAuthorization()
                isAnimating = true
            }
            .navigationTitle("Health Data")
        }
    }
}

//@main
struct HealthApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
