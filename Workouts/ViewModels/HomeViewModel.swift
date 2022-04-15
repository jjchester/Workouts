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
    @Published var weeklySteps: Int?
    @Published var isLoadingSteps = true
    @Published var isLoadingWeeklySteps = true
    init(healthController: HealthController) {
        self.healthController = healthController
        updateSteps()
    }
    
    func updateSteps() {
        // Don't want to reset loading state because this has to get called every time the home view appears. Better to just let it silently update without a progressview
        healthController.querySteps { steps in
            self.steps = Int(steps)
            self.isLoadingSteps = false
        }
        healthController.queryWeeklySteps { weeklySteps in
            self.weeklySteps = Int(weeklySteps)
            self.isLoadingWeeklySteps = false
        }
    }
    
}
