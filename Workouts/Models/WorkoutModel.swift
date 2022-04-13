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

struct WorkoutModel: Hashable {
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
            case "Mixed":
                _workoutType = .mixed
            default:
                _workoutType = .neither
            }
        }
    }
    
    var durationHours: Int = 0
    var durationMinutes: Int = 0
    
    var date: Date = Date()
    
    init(workoutType: String, date: Date) {
        self.workoutType = workoutType
        self.date = date
    }
    
    init(workoutType: String, date: Date, durationHours: Int, durationMinutes: Int) {
        self.workoutType = workoutType
        self.date = date
        self.durationHours = durationHours
        self.durationMinutes = durationMinutes
    }
    
    func toJson() -> [String: Any] {
        return [
            "type": workoutType,
            "date": date,
            "durationHours": durationHours,
            "durationMinutes": durationMinutes
        ]
    }
}
