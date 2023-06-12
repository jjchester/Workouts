//
//  WorkoutViewModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import HealthKit

class HomeViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    private var uid: String? = Auth.auth().currentUser?.uid
    private var healthController: HealthController
    @Published var steps: Int?
    @Published var averageWeeklySteps: Int?
    @Published var calories: Int?
    @Published var averageWeeklyCalories: Int?
    @Published var heartRateLow: Int?
    @Published var heartRateHigh: Int?
    @Published var heartRateAvg: Int?
    @Published var isLoadingSteps = true
    @Published var isLoadingWeeklySteps = true
    @Published var isLoadingCals = true
    @Published var isLoadingWeeklyCalories = true
    @Published var isLoadingHeartrate = true
    
    init(healthController: HealthController) {
        self.healthController = healthController
        updateSteps()
        updateCalories()
        updateHeartRate()
    }
    
    func updateSteps() {
        // Don't want to reset loading state because this has to get called every time the home view appears. Better to just let it silently update without a progressview
        healthController.querySteps { steps in
            self.steps = Int(steps)
            self.isLoadingSteps = false
        }
        healthController.queryWeeklySteps { weeklySteps in
            self.averageWeeklySteps = Int(weeklySteps)
            self.isLoadingWeeklySteps = false
        }
    }
    
    func updateCalories() {
        healthController.queryCalories { cals in
            self.calories = Int(cals)
            self.isLoadingCals = false
        }
        healthController.queryWeeklyCalories { cals in
            self.averageWeeklyCalories = Int(cals)
            self.isLoadingWeeklyCalories = false
        }
    }
    
    func updateHeartRate() {
        healthController.queryHeartrate { result in
            self.heartRateLow = result.0
            self.heartRateHigh = result.1
            self.heartRateAvg = result.2
            self.isLoadingHeartrate = false
        }
    }
    
}
