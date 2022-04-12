//
//  WorkoutViewModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class WorkoutViewModel: ObservableObject {
    
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

    init(docId: String) {
        self.docId = docId
        self.getUser()
    }
    
    func getUser() {
        let docref = db.collection("users").document(uid ?? " ").collection("workouts").document(docId)
        docref.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, snapshot.exists else {
                print("Snapshot does not exist")
                return
            }
            let workoutData = snapshot.data()!
            DispatchQueue.main.async {
                self.workoutModel = WorkoutModel(workoutType: workoutData["type"] as! String, date: (workoutData["date"] as! Timestamp).dateValue())
            }
        }
    }
}
typealias WorkoutVM = WorkoutViewModel
