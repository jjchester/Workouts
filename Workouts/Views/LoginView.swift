//
//  ContentView.swift
//  Workouts
//
//  Created by Justin Chester on 2022-04-09.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LoginView: View {
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
                .frame(width: 300, height: 300, alignment: .center)
                .padding(.bottom, 30)
            TextField("Email Address", text: $email)
                .frame(minHeight: 50)
                .textFieldStyle(TappableTextFieldStyle())
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .frame(minHeight: 50)
                .textFieldStyle(TappableTextFieldStyle())
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            NavigationLink("Forgot password?", destination: ForgotPasswordView())
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .trailing)
            if errorCode != nil {
                Text(errorCode!)
                    .foregroundColor(.red)
                    .padding()
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
                    .padding(.top, 20)
            })
                
            
            NavigationLink("Create Account", destination: SignUpView())
                .foregroundColor(.blue)
                .padding()
        }
        .edgesIgnoringSafeArea(.top)
        .padding()
        .background(.white)
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .frame(maxHeight: .infinity, alignment: .top)
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

struct SignUpView: View {
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var password = ""
    @State var passwordConfirm = ""
    @State var errorCode: String? = nil
    
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
            HStack {
                TextField("First name", text: $firstName)
                    .frame(minHeight: 50)
                    .textFieldStyle(TappableTextFieldStyle())
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
                TextField("Last name", text: $lastName)
                    .frame(minHeight: 50)
                    .textFieldStyle(TappableTextFieldStyle())
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .disableAutocorrection(true)
            }
            TextField("Email Address", text: $email)
                .frame(minHeight: 50)
                .textFieldStyle(TappableTextFieldStyle())
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            SecureField("Password", text: $password)
                .frame(minHeight: 50)
                .textFieldStyle(TappableTextFieldStyle())
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            SecureField("Confirm password", text: $passwordConfirm)
                .frame(minHeight: 50)
                .textFieldStyle(TappableTextFieldStyle())
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            if errorCode != nil {
                Text(errorCode!)
                    .foregroundColor(.red)
            }
            Button(action: {
                if !passwordsMatch() {
                    errorCode = "Passwords do not match"
                } else if firstName.isEmpty || lastName.isEmpty {
                    errorCode = "Name fields cannot be empty"
                } else {
                    authState.signUp(firstName: firstName, lastName: lastName, email: email, password: password, completion: { error in
                        errorCode = error
                    })
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
                .padding(.top, 30)
        }
        .edgesIgnoringSafeArea(.top)
        .padding(.top, 30)
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .frame(maxHeight: .infinity, alignment: .top)
        .onTapGesture {
            self.endTextEditing()
        }
    }
}

struct ForgotPasswordView: View {
    @State var email = ""
    @State var errorStr: String = ""
    @State var isResetDisabled: Bool = false

    @EnvironmentObject var authState: AuthState
    
    var body: some View {
        VStack {
            Image("dumbbell")
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .padding(.bottom, 30)
            Text("Enter your email address to request password reset email")
                .frame(alignment: .center)
                .multilineTextAlignment(.center)
            TextField("Email Address", text: $email, onEditingChanged: { _ in
                self.isResetDisabled = false
            })
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Text(errorStr)
                .foregroundColor(errorStr.contains("Failed") ? .red : .green)
            Button(action: {
                authState.resetEmail(email: email, completion: { error in
                    isResetDisabled = true
                    if error == 0 {
                        errorStr = "Successfully sent password reset email"
                    } else {
                        errorStr = "Failed to send password reset email"
                    }
                })
            }, label: {
                Text("Send Reset Email")
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)
            })
                .disabled(isResetDisabled)
                .opacity(isResetDisabled ? 0.6 : 1)
        }
        .padding()
        .padding(.leading, 30)
        .padding(.trailing, 30)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
