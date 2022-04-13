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
                VStack {
//                    AsyncImage(url: URL(string: viewModel.imageURL)) { phase in
//                        switch phase {
//                        case .empty:
//                            ProgressView()
//                                .frame(width: 120, height: 120)
//                        case .success(let image):
//                            ZStack(alignment: .bottomTrailing) {
//                                image.resizable()
//                                    .aspectRatio(contentMode: .fill)
//                                     .frame(width: 140, height: 140)
//                                     .clipShape(Circle())
//                                     .padding(4)
//                                Image(systemName: "pencil")
//                                        .font(.system(size: 24))
//                                        .padding(8)
//                                        .foregroundColor(.white)
//                                        .background(.blue)
//                                        .clipShape(Circle())
//                                        .overlay(
//                                            RoundedRectangle(cornerRadius: 20)
//                                                .stroke(Color.white, lineWidth: 2)
//                                        )
//                                        .onTapGesture {
//                                            self.isLoading = true
//                                        showSheet = true
//                                    }
//                            }
//
//                        case .failure:
//                            ProgressView()
//                                .frame(width: 120, height: 120)
//                        @unknown default:
//                            // Since the AsyncImagePhase enum isn't frozen,
//                            // we need to add this currently unused fallback
//                            // to handle any new cases that might be added
//                            // in the future:
//                            ProgressView()
//                                .frame(width: 120, height: 120)
//                        }
//                    }
                        FirebaseImage(id: FirebaseAuth.Auth.auth().currentUser?.uid ?? "placeholder", viewModel: self.viewModel)
                        if isLoading {
                            ProgressView()
                        }
                    }
                    .sheet(isPresented: $showSheet) {
                        ImagePicker(selectedImage: $image)
                    }
                    .onChange(of: image, perform: { image in
                        print("Image changed")
                        storageManager.upload(image: image) { url in
                            viewModel.imageURL = url
                            self.isLoading = false
                        }
                    })
                VStack(spacing: 1) {
                        Text(viewModel.name)
                            .font(.title2)
                        Text(viewModel.email)
                    }
                    .padding(.top, 16)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .top)

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

