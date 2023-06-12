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
        var startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        startDate = Calendar.current.startOfDay(for: startDate!)
        let endDate = Date()
        let predicate = HKObserverQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
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
    
    func queryCalories(completion: @escaping (Double) -> Void) {
        let calQuantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        var startDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        startDate = Calendar.current.startOfDay(for: startDate!)
        let endDate = Date()
        let predicate = HKObserverQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let calQuery = HKStatisticsQuery(quantityType: calQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("\(String(describing: error?.localizedDescription)) ")
                completion(resultCount)
                return
            }

            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.kilocalorie())
            }

            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(calQuery)
    }
    
    func queryWeeklyCalories(completion: @escaping (Double) -> Void) {
        let calQuantityType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        var startDate = Calendar.current.date(byAdding: .day, value: -6, to: Date())
        startDate = Calendar.current.startOfDay(for: startDate!)
        let endDate = Date()
        let predicate = HKObserverQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
        let calQuery = HKStatisticsQuery(quantityType: calQuantityType, quantitySamplePredicate: predicate, options: .cumulativeSum) { (_, result, error) in
            var resultCount = 0.0
            guard let result = result else {
                print("\(String(describing: error?.localizedDescription)) ")
                completion(resultCount)
                return
            }

            if let sum = result.sumQuantity() {
                resultCount = sum.doubleValue(for: HKUnit.kilocalorie())/7
            }

            DispatchQueue.main.async {
                completion(resultCount)
            }
        }
        healthStore.execute(calQuery)
    }
    
    /*Method to get todays heart rate - this only reads data from health kit. */
     func queryHeartrate(completion: @escaping ((Int, Int, Int)) -> Void) {
        //predicate
        let calendar = NSCalendar.current
        let now = NSDate()
        let components = calendar.dateComponents([.year, .month, .day], from: now as Date)
        let heartRateType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!
         
        guard let startDate:NSDate = calendar.date(from: components) as NSDate? else { return }
        var dayComponent    = DateComponents()
        dayComponent.day    = 1
        let endDate:NSDate? = calendar.date(byAdding: dayComponent, to: startDate as Date) as NSDate?
        let predicate = HKQuery.predicateForSamples(withStart: startDate as Date, end: endDate as Date?, options: [])

        //descriptor
        let sortDescriptors = [
                                NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
                              ]
        
         let heartRateQuery = HKSampleQuery(sampleType: heartRateType, predicate: predicate, limit: 25, sortDescriptors: sortDescriptors, resultsHandler: { (query, results, error) in
            guard error == nil else { print("error"); return }
             let result = gettHeartRateInfo(results: results)
             DispatchQueue.main.async {
                 completion(result)
             }
        }) //eo-query
        
        healthStore.execute(heartRateQuery)
     }//eom
    
    /*used only for testing, prints heart rate info */
    private func gettHeartRateInfo(results:[HKSample]?) -> (Int, Int, Int)
    {
        let heartRateUnit:HKUnit = HKUnit(from: "count/min")
        let count = results!.count
        if count == 0 {
            return (0,0,0)
        }
        var avg = 0.0
        var low = 999.0
        var high = 0.0
        for (_, sample) in results!.enumerated() {
            guard let currData:HKQuantitySample = sample as? HKQuantitySample else { return (0,0,0) }
            let current = currData.quantity.doubleValue(for: heartRateUnit)
            if low > current {
                low = current
            }
            else if high < current {
                high = current
            }
//            print("[\(sample)]")
//            print("Heart Rate: \(currData.quantity.doubleValue(for: heartRateUnit))")
            avg = avg + current
//            print("quantityType: \(currData.quantityType)")
//            print("Start Date: \(currData.startDate)")
//            print("End Date: \(currData.endDate)")
//            print("Metadata: \(currData.metadata)")
//            print("UUID: \(currData.uuid)")
//            print("Source: \(currData.sourceRevision)")
//            print("Device: \(currData.device)")
//            print("---------------------------------\n")
        }//eofl
        return(Int(low), Int(high), Int(avg))
    }//eom
    
}
