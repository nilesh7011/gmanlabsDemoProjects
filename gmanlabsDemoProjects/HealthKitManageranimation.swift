//
//  HealthKitManageranimation.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 31/05/24.
//



import HealthKit
import SwiftUI

class HealthKitManageranimation: ObservableObject {
    private var healthStore = HKHealthStore()
    
    @Published var steps: [HealthData] = []
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let readTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            completion(success)
        }
    }
    
    func fetchStepData() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { [weak self] _, result, error in
            guard let result = result, let sum = result.sumQuantity() else { return }
            let steps = Int(sum.doubleValue(for: HKUnit.count()))
            
            DispatchQueue.main.async {
                self?.steps.append(HealthData(date: Date(), steps: steps))
            }
        }
        
        healthStore.execute(query)
    }
}

struct HealthData: Identifiable {
    let id = UUID()
    let date: Date
    let steps: Int
}


//struct HealthKitManageranimation_Previews: PreviewProvider {
//    static var previews: some View {
//        HealthKitManageranimation()
//    }
//}
