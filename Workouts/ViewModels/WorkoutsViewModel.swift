//
//  WorkoutViewModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class WorkoutsViewModel: ObservableObject {
    
    let db = Firestore.firestore()
    var uid: String? = Auth.auth().currentUser?.uid
    @Published var docIds: [String] = []
    @Published var isLoading = false

    init() {
        self.getUser()
    }
    
    func getUser() {
        db.collection("users").document(uid ?? " ").collection("workouts").order(by: "date", descending: true)
            .addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("Error getting documents: \(error)")
                    } else {
                        self.docIds = []
                        for document in querySnapshot!.documents {
                            let data = document.data()
                            let model = WorkoutModel(workoutType: data["type"] as! String, date: (data["date"] as! Timestamp).dateValue())
                            self.docIds.append(document.documentID)
                            self.isLoading = false
                        }
                    }
            }
    }
}
typealias WorkoutsVM = WorkoutsViewModel
