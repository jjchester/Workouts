//
//  SettingsView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI
import FirebaseStorage
import FirebaseAuth
import UIKit

struct ProfileView: View {
    
    @EnvironmentObject var authState: AuthState
    @ObservedObject var viewModel: ProfileVM = ProfileVM()
    @State private var image: UIImage = UIImage()
    @State private var showSheet = false
    @State var showCaptureImageView = false
    @State var isLoading = false
    var storageManager = StorageManager()
    
    var body: some View {
        ZStack {
            VStack {
                FirebaseImage(id: FirebaseAuth.Auth.auth().currentUser?.uid ?? "placeholder", viewModel: self.viewModel)
                VStack(spacing: 1) {
                    Text(viewModel.name)
                        .font(.title2)
                    Text(viewModel.email)
                }
                .padding(.top, 16)
            }
            .padding(.top, 30)
            .frame(maxHeight: .infinity, alignment: .top)

            Button(action: {
                self.authState.signOut()
            }, label: {
                Text("Sign Out")
                    .foregroundColor(.red)
                    .frame(width: 160, height: 40)
                    .cornerRadius(10)
            })
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding()
        }
    }
}

