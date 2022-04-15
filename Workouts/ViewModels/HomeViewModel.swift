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
    @Published var steps: Double?
    @Published var isLoading = false
    
    init(healthController: HealthController) {
        self.healthController = healthController
        updateSteps()
    }
    
    func updateSteps() {
        isLoading = true
        healthController.querySteps { steps in
            self.steps = steps
            self.isLoading = false
        }
    }
    
}
