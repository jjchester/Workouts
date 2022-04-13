//
//  WorkoutDetailsView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-12.
//

import SwiftUI

struct WorkoutDetailsView: View {
    
    @ObservedObject var vm: WorkoutViewModel
    @State var err: String? = nil
    @State var isPresented = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if err != nil {
                Text(err!)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                self.isPresented = true
            }, label: {
                Text("Delete workout")
                    .foregroundColor(.red)
                    .frame(width: 160, height: 40)
                    .cornerRadius(10)
            })
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
        }
        .alert(isPresented: $isPresented) {
            Alert(
                title: Text("Are you sure you want to delete this workout?"),
                message: Text("This cation cannot be undone"),
                primaryButton: .destructive(Text("Delete")) {
                    self.vm.deleteWorkout { error in
                        self.err = error
                    }
                    if (self.err == nil) {
                        dismiss()
                    }
                },
                secondaryButton: .cancel()
            )
        }
    }
}
