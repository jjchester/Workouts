//
//  ContentView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    
    @EnvironmentObject var authState: AuthState
    
    var body: some View {
        NavigationView {
            if (authState.isSignedIn) {
                MainView()
                    .environmentObject(authState)
            } else {
                SignInView()
            }
        }
        .onAppear {
            authState.signedIn = authState.isSignedIn
        }
        .navigationTitle("Sign In")
    }
}

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var alert = true
    @State var errorCode: String? = nil

    @EnvironmentObject var authState: AuthState
    
    var body: some View {
        VStack {
            Image("dumbbell")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding(.bottom, 30)
            TextField("Email Address", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            if errorCode != nil {
                Text(errorCode!)
                    .foregroundColor(.red)
            }
            Button(action: {
                authState.signIn(email: self.email, password: self.password, completion: { error in
                    errorCode = error
                })
            }, label: {
                Text("Sign In")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
                
            
            NavigationLink("Create Account", destination: SignUpView())
                .padding()
        }
        .padding()
        .padding(.bottom, 100)
    }
}

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    @State var mismatchedPasswords = false
    
    @EnvironmentObject var authState: AuthState
    
    func passwordsMatch() -> Bool {
        password == passwordConfirm
    }
    
    func passwordsEmpty() -> Bool {
        return password.isEmpty || passwordConfirm.isEmpty
    }
    
    var body: some View {
        VStack {
            Image("dumbbell")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .padding(.bottom, 30)
            TextField("Email Address", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            SecureField("Confirm password", text: $passwordConfirm)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            if self.mismatchedPasswords {
                Text("Passwords do not match")
                    .foregroundColor(.red)
                    .frame(alignment: .leading)
            }
            Button(action: {
                if !passwordsMatch() {
                    self.mismatchedPasswords = true
                } else {
                    self.mismatchedPasswords = false
                    self.authState.signUp(email: self.email, password: self.password)
                }
            }, label: {
                Text("Sign Up")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .opacity(passwordsEmpty() ? 0.6 : 1)
                    .disabled(passwordsEmpty())
            })
        }
        .padding()
        .padding(.bottom, 70)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
