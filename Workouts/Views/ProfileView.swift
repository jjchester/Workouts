//
//  SettingsView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject var authState: AuthState
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                VStack {
                    AsyncImage(url: URL(string: "https://external-preview.redd.it/3vM1pbiUOHHzTFeQkBdbVS4lUY2fJl70DfKSlZ8mQyc.png?auto=webp&s=9e578d42143d3da43058ca88833d25a22f847ee6")) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 120, height: 120)
                        case .success(let image):
                            image.resizable()
                                 .aspectRatio(contentMode: .fit)
                                 .frame(width: 120, height: 120)
                                 .clipShape(Circle())
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            // Since the AsyncImagePhase enum isn't frozen,
                            // we need to add this currently unused fallback
                            // to handle any new cases that might be added
                            // in the future:
                            EmptyView()
                        }
                    }
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
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.red)
                        .cornerRadius(10)
                })
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
