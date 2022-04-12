//
//  WorkoutModel.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-12.
//

import Foundation

enum WorkoutType {
    case cardio
    case strength
    case mixed
    case neither
}

struct WorkoutModel {
    private var _workoutType: WorkoutType = .neither
    
    var workoutType: String {
        get {
            switch _workoutType {
            case .strength:
                return "Strength"
            case .cardio:
                return "Cardio"
            case .mixed :
                return "Mixed"
            default:
                return "Neither"
            }
        }
        set {
            switch newValue {
            case "Strength":
                _workoutType = .strength
            case "Cardio":
                _workoutType = .cardio
            default:
                _workoutType = .mixed
            }
        }
    }
    
    var date: Date = Date()
    
    init(workoutType: String, date: Date) {
        self.workoutType = workoutType
        self.date = date
    }
    
    func toJson() -> [String: Any] {
        return [
            "type": workoutType,
            "date": date
        ]
    }
}
