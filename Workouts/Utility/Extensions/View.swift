//
//  View.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-14.
//

import Foundation
import SwiftUI

extension View {
  func endTextEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                    to: nil, from: nil, for: nil)
  }
}
