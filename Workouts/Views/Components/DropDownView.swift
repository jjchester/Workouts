//
//  DropDownView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-12.
//

import SwiftUI

struct DropDownView: View {
    @State var value = ""
    var placeholder = "Select Client"
    var dropDownList = ["PSO", "PFA", "AIR", "HOT"]
    var completion: (String) -> ()
    
    init(placeholder: String, dropDownList: [String], completion: @escaping (String) -> ()) {
        self.placeholder = placeholder
        self.dropDownList = dropDownList
        self.completion = completion
    }
    
    var body: some View {
        Menu {
            ForEach(dropDownList, id: \.self){ client in
                Button(client) {
                    self.value = client
                    completion(self.value)
                }
            }
        } label: {
            VStack(spacing: 5){
                HStack{
                    Text(value.isEmpty ? placeholder : value)
                        .foregroundColor(value.isEmpty ? .gray : .black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(Color.blue)
                        .font(Font.system(size: 16))
                }
                .padding(.horizontal)
                .frame(maxWidth: 220)
                Rectangle()
                    .fill(Color.blue)
                    .frame(maxWidth: 220, maxHeight: 2)
            }
        }
    }
}

struct DropDownView_Previews: PreviewProvider {
    static var previews: some View {
        DropDownView(placeholder: "", dropDownList: []) { _ in
            
        }
    }
}
