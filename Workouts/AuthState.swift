//
//  AuthState.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import Foundation
import FirebaseAuth

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
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil && error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}
