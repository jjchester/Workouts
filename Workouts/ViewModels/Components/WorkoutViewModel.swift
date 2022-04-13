//
//  WorkoutViewModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class WorkoutViewModel: ObservableObject, Hashable {
    static func == (lhs: WorkoutViewModel, rhs: WorkoutViewModel) -> Bool {
        return lhs.docId == rhs.docId && lhs.workoutType == rhs.workoutType
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(docId)
    }
    
    
    var docId: String
    let db = Firestore.firestore()
    var uid: String? = Auth.auth().currentUser?.uid
    @Published var workoutModel = WorkoutModel(workoutType: "Neither", date: Date())
    
    var workoutType: String {
        get {
            return workoutModel.workoutType
        }
    }
    
    var date: Date {
        get {
            return workoutModel.date
        }
    }

    var duration: String {
        get {
            if self.workoutModel.durationHours == 0 {
                return "\(self.workoutModel.durationMinutes) minutes"
            }
            else if self.workoutModel.durationHours == 1 {
                if self.workoutModel.durationMinutes == 0 {
                    return "\(self.workoutModel.durationHours) hour"
                } else {
                    return "\(self.workoutModel.durationHours) hour \(self.workoutModel.durationMinutes) minutes"
                }
            } else {
                if self.workoutModel.durationMinutes == 0 {
                    return "\(self.workoutModel.durationHours) hours"
                } else {
                    return "\(self.workoutModel.durationHours) hours \(self.workoutModel.durationMinutes) minutes"
                }
            }
        }
    }
    
    init(docId: String) {
        print("Init")
        self.docId = docId
    }
    
    init(docId: String, model: WorkoutModel) {
        self.docId = docId
        self.workoutModel = model
    }
    
    func getWorkout() {
        let docref = db.collection("users").document(uid ?? "test").collection("workouts").document(docId)
        docref.getDocument() { snapshot, error in
            guard let snapshot = snapshot, snapshot.exists else {
                print("Snapshot does not exist")
                return
            }
            let workoutData = snapshot.data()!
            DispatchQueue.main.async {
                print(Date(timeIntervalSince1970: Double((workoutData["date"] as! Timestamp).seconds)))
                self.workoutModel = WorkoutModel(workoutType: workoutData["type"] as! String, date: (workoutData["date"] as! Timestamp).dateValue())
            }
        }
    }
    
    func deleteWorkout(completion: @escaping (String?) -> ()) {
        db.collection("users").document(uid ?? "test").collection("workouts").document(docId).delete() { err in
            if let err = err {
                completion(err.localizedDescription)
                return
            }
            completion(nil)
        }
    }
}
typealias WorkoutVM = WorkoutViewModel
