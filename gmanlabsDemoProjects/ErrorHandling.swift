//
//  ErrorHandling.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 31/05/24.
//

import SwiftUI
import Charts
let sampleData: [HealthData] = [
    HealthData(date: Calendar.current.date(byAdding: .day, value: -6, to: Date())!, steps: 12000),
    HealthData(date: Calendar.current.date(byAdding: .day, value: -5, to: Date())!, steps: 15000),
    HealthData(date: Calendar.current.date(byAdding: .day, value: -4, to: Date())!, steps: 13000),
    HealthData(date: Calendar.current.date(byAdding: .day, value: -3, to: Date())!, steps: 11000),
    HealthData(date: Calendar.current.date(byAdding: .day, value: -2, to: Date())!, steps: 10000),
    HealthData(date: Calendar.current.date(byAdding: .day, value: -1, to: Date())!, steps: 9000),
    HealthData(date: Date(), steps: 14000)
]
enum HealthDataError: Error, LocalizedError {
    case dataUnavailable
    case authorizationDenied
    
    var errorDescription: String? {
        switch self {
        case .dataUnavailable:
            return "Health data is unavailable."
        case .authorizationDenied:
            return "Authorization to access health data was denied."
        }
    }
}
func fetchHealthData(completion: @escaping (Result<[HealthData], HealthDataError>) -> Void) {
    // Simulating a delay for fetching data
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        // Randomly decide if the fetch is successful or fails
        let success = Bool.random()
        if success {
            completion(.success(sampleData))
        } else {
            completion(.failure(.dataUnavailable))
        }
    }
}


struct AnimatedBarChartView1: View {
    @State private var animatedEntries: [BarChartDataEntry] = []
    @State private var errorMessage: String?
    
    var body: some View {
        VStack {
            Text("Health Data")
                .font(.title)
                .padding()
            
            Button(action: {
                fetchHealthData { result in
                    switch result {
                    case .success(let healthData):
                        withAnimation(.easeInOut(duration: 2.0)) {
                            animatedEntries = healthData.map { dataPoint in
                                BarChartDataEntry(x: Double(dataPoint.date.timeIntervalSince1970), y: Double(dataPoint.steps))
                            }
                        }
                    case .failure(let error):
                        errorMessage = error.localizedDescription
                    }
                }
            }) {
                Text("Fetch Health Data")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            BarChartViewRepresentable(entries: animatedEntries)
                .frame(height: 300)
                .padding()
        }
    }
}

struct ContentView2: View {
    var body: some View {
        NavigationView {
            AnimatedBarChartView()
                .navigationTitle("Health Dashboard")
        }
    }
}

//@main
struct HealthApp2: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}


