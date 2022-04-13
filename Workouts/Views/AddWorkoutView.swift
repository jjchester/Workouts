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
    @State var startTime: Date = Date.now.nearestHour()!
    @State var endTime: Date = (Date.now + 3600).nearestHour()!
    
    var body: some View {
        VStack {
            Text("Start time")
                .frame(alignment: .leading)
            DatePicker("Start time", selection: $startTime, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .padding(.bottom)
                .onAppear { UIDatePicker.appearance().minuteInterval = 5 }
            Text("End time")
                .frame(alignment: .leading)
            DatePicker("End time", selection: $endTime, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()
                .padding(.bottom)
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
                self.vm.addData(startTime: startTime, endTime: endTime) { error in
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
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 40)
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
