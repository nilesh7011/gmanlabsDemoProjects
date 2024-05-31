//
//  HealthChartView.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 31/05/24.
//

import SwiftUI
import Charts


struct BarChartViewRepresentable: UIViewRepresentable {
    var entries: [BarChartDataEntry]

    func makeUIView(context: Context) -> BarChartView {
        let chart = BarChartView()
        chart.noDataText = "No data available."
        return chart
    }

    func updateUIView(_ uiView: BarChartView, context: Context) {
        let dataSet = BarChartDataSet(entries: entries, label: "Steps")
        dataSet.colors = ChartColorTemplates.material()
        let data = BarChartData(dataSet: dataSet)
        uiView.data = data
        uiView.animate(yAxisDuration: 2.0)
    }
}

struct BarChartViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        BarChartViewRepresentable(entries: [
            BarChartDataEntry(x: 1, y: 12000),
            BarChartDataEntry(x: 2, y: 15000),
            BarChartDataEntry(x: 3, y: 13000),
            BarChartDataEntry(x: 4, y: 11000),
            BarChartDataEntry(x: 5, y: 10000),
            BarChartDataEntry(x: 6, y: 9000),
            BarChartDataEntry(x: 7, y: 14000)
        ])
    }
}



struct AnimatedBarChartView: View {
    @State private var animatedEntries: [BarChartDataEntry] = []
    let sampleEntries: [BarChartDataEntry] = [
        BarChartDataEntry(x: 1, y: 12000),
        BarChartDataEntry(x: 2, y: 15000),
        BarChartDataEntry(x: 3, y: 13000),
        BarChartDataEntry(x: 4, y: 11000),
        BarChartDataEntry(x: 5, y: 10000),
        BarChartDataEntry(x: 6, y: 9000),
        BarChartDataEntry(x: 7, y: 14000)
    ]
    var body: some View {
        VStack {
            Text("Health Data")
                .font(.title)
                .padding()

            Button(action: {
                withAnimation(.easeInOut(duration: 2.0)) {
                    animatedEntries = sampleEntries
                }
            }) {
                Text("Fetch Health Data")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            BarChartViewRepresentable(entries: animatedEntries)
                .frame(height: 300)
                .padding()
        }
    }
}

struct ContentView1: View {
    var body: some View {
        NavigationView {
            AnimatedBarChartView()
                .navigationTitle("")
        }
    }
}

//@main
struct HealthApp1: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
