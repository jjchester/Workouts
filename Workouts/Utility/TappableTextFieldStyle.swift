//
//  TappableTextFieldStyle.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-14.
//

import Foundation
import SwiftUI

struct TappableTextFieldStyle: TextFieldStyle {
    @FocusState private var textFieldFocused: Bool
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .focused($textFieldFocused)
            .onTapGesture {
                textFieldFocused = true
            }
    }
}
