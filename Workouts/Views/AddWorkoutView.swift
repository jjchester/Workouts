//
//  AddWorkoutView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-12.
//

import SwiftUI

struct AddWorkoutView: View {

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @ObservedObject var vm = AddWorkoutVM()
    @State var err: String? = nil

    
    var body: some View {
        VStack {
            DropDownView(placeholder: vm.placeholder, dropDownList: vm.options, completion: { str in
                vm.value = str
            })
            if err != nil {
                Text(err!)
                    .foregroundColor(.red)
            }
            Button(action: {
                guard vm.value != nil else {
                    err = "Please select a type"
                    return
                }
                self.vm.addData() { error in
                    guard error == nil else {
                        err = "Unable to add workout"
                        return
                    }
                    err = nil
                    self.presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Text("Add")
            }
            )
                .frame(width: 100, height: 40, alignment: .center)
                .border(.blue)
        }
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
