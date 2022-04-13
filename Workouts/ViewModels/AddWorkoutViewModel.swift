//
//  AddWorkoutViewModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-12.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class AddWorkoutViewModel: ObservableObject {
    
    @Published var value: String? = nil
    var placeholder = "Select exercise type"
    var options = ["Cardio", "Strength", "Mixed"]
    
    func addData(startTime: Date, endTime: Date, completion: @escaping (Int?) -> ()) {
        let duration = Int((endTime - startTime).rounded())
        var durationMinutes = (duration/60)%60
        if durationMinutes % 5 != 0 {
            durationMinutes += 1
        }
        let durationHours = duration/3600
        // Get a reference to db
        let db = Firestore.firestore()
        let uid = FirebaseAuth.Auth.auth().currentUser?.uid
        var err: Int? = nil
        db.collection("users").document(uid!).collection("workouts").addDocument(
            data: WorkoutModel(workoutType: value!, date: startTime, durationHours: durationHours, durationMinutes: durationMinutes).toJson()
        ) { error in
            if error != nil {
                err = (error! as NSError).code
            }
            completion(err)
        }
    }
}
typealias AddWorkoutVM = AddWorkoutViewModel
