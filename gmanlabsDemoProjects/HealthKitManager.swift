//
//  HealthKitManager.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 30/05/24.
//

import SwiftUI

import HealthKit

class HealthKitManager: ObservableObject {
    private let healthStore = HKHealthStore()
    
    @Published var steps: Double = 0
    @Published var distance: Double = 0
    @Published var heartRates: [Double] = []
    @Published var errorMessage: String? = nil
    
    func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else {
            self.errorMessage = "Health data not available on this device."
            return
        }
        
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!
        ]
        
        let writeTypes: Set<HKSampleType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!
        ]
        
        healthStore.requestAuthorization(toShare: writeTypes, read: readTypes) { success, error in
            if !success || error != nil {
                DispatchQueue.main.async {
                    self.errorMessage = error?.localizedDescription ?? "Authorization failed."
                }
            } else {
                self.addSampleData()
                self.fetchHealthData()
            }
        }
    }
    
    private func fetchHealthData() {
        fetchSteps()
        fetchDistance()
        fetchHeartRate()
    }
    
    private func fetchSteps() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            let steps = result?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
            DispatchQueue.main.async {
                self.steps = steps
            }
        }
        
        healthStore.execute(query)
    }
    
    private func fetchDistance() {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            let distance = result?.sumQuantity()?.doubleValue(for: HKUnit.meter()) ?? 0
            DispatchQueue.main.async {
                self.distance = distance
            }
        }
        
        healthStore.execute(query)
    }
    
    private func fetchHeartRate() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        
        let predicate = HKQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            
            let heartRates = (samples as? [HKQuantitySample])?.map { $0.quantity.doubleValue(for: HKUnit(from: "count/min")) } ?? []
            DispatchQueue.main.async {
                self.heartRates = heartRates
            }
        }
        
        healthStore.execute(query)
    }
    
    func addSampleData() {
        addStepCountSample()
        addDistanceSample()
        addHeartRateSample()
    }
    
    private func addStepCountSample() {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let quantity = HKQuantity(unit: HKUnit.count(), doubleValue: 1000)
        let now = Date()
        let sample = HKQuantitySample(type: stepType, quantity: quantity, start: now, end: now)
        
        healthStore.save(sample) { success, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func addDistanceSample() {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let quantity = HKQuantity(unit: HKUnit.meter(), doubleValue: 1000)
        let now = Date()
        let sample = HKQuantitySample(type: distanceType, quantity: quantity, start: now, end: now)
        
        healthStore.save(sample) { success, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func addHeartRateSample() {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let quantity = HKQuantity(unit: HKUnit(from: "count/min"), doubleValue: 80)
        let now = Date()
        let sample = HKQuantitySample(type: heartRateType, quantity: quantity, start: now, end: now)
        
        healthStore.save(sample) { success, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}


//struct HealthKitManager_Previews: PreviewProvider {
//    static var previews: some View {
//        HealthKitManager()
//    }
//}
