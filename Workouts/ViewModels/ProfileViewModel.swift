//
//  ProfileViewModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import Firebase

class ProfileViewModel: ObservableObject {
    @Published var user: UserModel = UserModel(uid: "", firstName: "", lastName: "", email: "")
    var firstName: String {
        get {
            return user.firstName
        }
    }
    var lastName: String {
        get {
            return user.lastName
        }
    }
    var name: String {
        get {
            return user.name
        }
    }
    var email: String {
        get {
            return user.email
        }
    }
    
    let db = Firestore.firestore()
    var uid: String? = Auth.auth().currentUser?.uid
    
    init() {
        self.getUser()
    }
    
    func getUser() {
        let docref = db.collection("users").document(uid ?? " ")
//        docref.getDocument { [self] document, error in
//            guard let document = document, document.exists else {
//                print("Document does not exist")
//                return
//            }
//            let userData = document.data()!
//            DispatchQueue.main.async {
//                user = UserModel(uid: userData["uid"] as! String, firstName: userData["firstName"] as! String, lastName: userData["lastName"] as! String, email: userData["email"] as! String)
//            }
//        }
        docref.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot, snapshot.exists else {
                print("Snapshot does not exist")
                return
            }
            let userData = snapshot.data()!
            DispatchQueue.main.async {
                self.user = UserModel(uid: userData["uid"] as! String, firstName: userData["firstName"] as! String, lastName: userData["lastName"] as! String, email: userData["email"] as! String)
            }
        }
    }
}
