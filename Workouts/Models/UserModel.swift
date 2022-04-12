//
//  UserModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-11.
//

import Foundation

struct UserModel {
    
    var uid: String
    var firstName: String
    var lastName: String
    var email: String
    var name: String {
        get {
            return firstName + " " + lastName
        }
    }
    
    func toJson() -> [String: Any]{
        return [
            "uid": self.uid,
            "firstName": self.firstName,
            "lastName": self.lastName,
            "email": self.email
        ]
    }
    
}
