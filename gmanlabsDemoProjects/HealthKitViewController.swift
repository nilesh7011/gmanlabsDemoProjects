//
//  HealthKitViewController.swift
//  gmanlabsDemoProjects
//
//  Created by m8nilesh on 30/05/24.
//

import UIKit
import HealthKit
import SwiftUI

class HealthKitViewController: UIViewController {
    
    @IBOutlet weak var healthview: UIView!
    
    @IBOutlet weak var nxtpage: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nxtpage.layer.borderColor = UIColor(red: 224/255.0, green: 233/255.0, blue: 255/255.0, alpha: 1.0).cgColor
        nxtpage.layer.borderWidth = 1
        nxtpage.layer.cornerRadius = 15
        
        //MARK: - Swift to SwiftUI view
        
        let vc = UIHostingController(rootView: ContentView())
        let swiftuiView = vc.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(vc)
        self.healthview.addSubview(swiftuiView)
        NSLayoutConstraint.activate([
            swiftuiView.leadingAnchor.constraint(equalTo: self.healthview.leadingAnchor),
            swiftuiView.trailingAnchor.constraint(equalTo: self.healthview.trailingAnchor),
            swiftuiView.topAnchor.constraint(equalTo: self.healthview.topAnchor),
            swiftuiView.bottomAnchor.constraint(equalTo: self.healthview.bottomAnchor)
        ])
        vc.didMove(toParent: self)
        
    }
    
    @IBAction func Nxtpge(_ sender: Any) {
        
        let viewC = (self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController")) as! TabBarViewController
        self.navigationController?.pushViewController(viewC, animated: true)
        
    }
    
    
    //    class HealthKitManager {
    let healthStore = HKHealthStore()
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, nil)
            return
        }
        
        let readTypes: Set<HKObjectType> = [
            HKObjectType.quantityType(forIdentifier: .stepCount)!,
            HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
            HKObjectType.quantityType(forIdentifier: .heartRate)!
        ]
        
        healthStore.requestAuthorization(toShare: nil, read: readTypes) { success, error in
            completion(success, error)
        }
    }
    
    func fetchStepCount(completion: @escaping (Double) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            var stepCount: Double = 0
            if let result = result, let sum = result.sumQuantity() {
                stepCount = sum.doubleValue(for: HKUnit.count())
            }
            DispatchQueue.main.async {
                completion(stepCount)
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchDistance(completion: @escaping (Double) -> Void) {
        let distanceType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKStatisticsQuery(quantityType: distanceType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, result, error in
            var distance: Double = 0
            if let result = result, let sum = result.sumQuantity() {
                distance = sum.doubleValue(for: HKUnit.meter())
            }
            DispatchQueue.main.async {
                completion(distance)
            }
        }
        
        healthStore.execute(query)
    }
    
    func fetchHeartRate(completion: @escaping ([Double]) -> Void) {
        let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        let startDate = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let query = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, samples, error in
            var heartRates: [Double] = []
            if let samples = samples as? [HKQuantitySample] {
                heartRates = samples.map { $0.quantity.doubleValue(for: HKUnit(from: "count/min")) }
            }
            DispatchQueue.main.async {
                completion(heartRates)
            }
        }
        
        healthStore.execute(query)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}



