//
//  Steps.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-15.
//

import Foundation
import HealthKit

struct HealthController {
    var healthStore: HKHealthStore = HKHealthStore()
    
    func querySteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = HKObserverQuery.predicateForSamples(withStart: startOfDay, end: now, options: .strictStartDate)
    /*
     Need a paid apple developer account for background delivery of health data so for now I have to just have it refreshing every time the page appears by re-querying
     It technically works fine in simulator but I need to test on a physical device sometimes so it's not worth the headache
     Also need to add these lines back to Workouts.entitlements:
     <key>com.apple.developer.healthkit.background-delivery</key>
     <true/>
     */
//        healthStore.enableBackgroundDelivery(for: stepType, frequency: .immediate) { success, error in
//            print("Observer Query background delivery enabled -> successful: \(success) error: \(String(describing: error))")
//        }
//
//        let ObserverQuery = HKObserverQuery(sampleType: stepType, predicate: nil) { observerQuery, completionHandler, error in
//            if error == nil {
//                let stepQuery = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
//                    var resultCount = 0.0
//
//                    guard let result = result else {
//                        print("\(String(describing: error?.localizedDescription)) ")
//                        completion(resultCount)
//                        return
//                    }
//
//                    if let sum = result.sumQuantity() {
//                        resultCount = sum.doubleValue(for: HKUnit.count())
//                    }
//
//                    DispatchQueue.main.async {
//                        completion(resultCount)
//                    }
//                }
//                healthStore.execute(stepQuery)
//                completionHandler()
//            }
//        }
//        healthStore.execute(ObserverQuery)
        let stepQuery = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("\(String(describing: error?.localizedDescription)) ")
                completion(resultCount)
                return
            }

            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())
            }

            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(stepQuery)
    }
    
    func queryWeeklySteps(completion: @escaping (Double) -> Void) {
        let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
//        let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
        var startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        startDate = Calendar.current.startOfDay(for: startDate!)
        let endDate = Date()
        let predicate = HKObserverQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    /*
     Need a paid apple developer account for background delivery of health data so for now I have to just have it refreshing every time the page appears by re-querying
     It technically works fine in simulator but I need to test on a physical device sometimes so it's not worth the headache
     Also need to add these lines back to Workouts.entitlements:
     <key>com.apple.developer.healthkit.background-delivery</key>
     <true/>
     */
//        healthStore.enableBackgroundDelivery(for: stepType, frequency: .immediate) { success, error in
//            print("Observer Query background delivery enabled -> successful: \(success) error: \(String(describing: error))")
//        }
//
//        let ObserverQuery = HKObserverQuery(sampleType: stepType, predicate: nil) { observerQuery, completionHandler, error in
//            if error == nil {
//                let stepQuery = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
//                    var resultCount = 0.0
//
//                    guard let result = result else {
//                        print("\(String(describing: error?.localizedDescription)) ")
//                        completion(resultCount)
//                        return
//                    }
//
//                    if let sum = result.sumQuantity() {
//                        resultCount = sum.doubleValue(for: HKUnit.count())
//                    }
//
//                    DispatchQueue.main.async {
//                        completion(resultCount)
//                    }
//                }
//                healthStore.execute(stepQuery)
//                completionHandler()
//            }
//        }
//        healthStore.execute(ObserverQuery)
        let stepQuery = HKStatisticsQuery(quantityType: stepsQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("\(String(describing: error?.localizedDescription)) ")
                completion(resultCount)
                return
            }

            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.count())/7
            }

            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(stepQuery)
    }
}
