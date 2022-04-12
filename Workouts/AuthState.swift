//
//  AuthState.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthState: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String, completion: @escaping (String?) -> () ) {
        var e: String? = nil
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil && error == nil else {
                if let x = error {
                     let err = x as NSError
                    switch err.code {
                        case AuthErrorCode.wrongPassword.rawValue:
                            e = "Incorrect password"
                        case AuthErrorCode.invalidEmail.rawValue:
                            e = "Invalid email address"
                        default:
                            e = "unknown error: \(err.localizedDescription)"
                    }
                }
                completion(e)
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
        return
    }
    
    func signUp(firstName: String, lastName: String, email: String, password: String, completion: @escaping (String?) -> () ) {
        var e: String? = nil
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil && error == nil else {
                if let x = error {
                     let err = x as NSError
                    switch err.code {
                        case AuthErrorCode.emailAlreadyInUse.rawValue:
                            e = "That email address is already in use"
                        case AuthErrorCode.weakPassword.rawValue:
                            e = "Password must be at least 6 characters"
                        case AuthErrorCode.invalidEmail.rawValue:
                            e = "Invalid email address"
                        default:
                            e = "unknown error: \(err.localizedDescription)"
                    }
                }
                completion(e)
                return
            }
            let uid = self!.auth.currentUser!.uid;
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).setData(UserModel(uid: uid, firstName: firstName, lastName: lastName, email: email).toJson())
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
    
    func resetEmail(email: String, completion: @escaping (Int) -> () ) {
        auth.sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                print((error! as NSError).code)
                completion(1)
                return
            }
            completion(0)
        }
        
    }
}
