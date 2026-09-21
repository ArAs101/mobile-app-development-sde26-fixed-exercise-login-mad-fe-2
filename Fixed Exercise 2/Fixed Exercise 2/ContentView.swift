// xcode: set sdk=iOS

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    private enum Field {
        case email
        case password
    }
    
    @FocusState private var focusedField: Field?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(alignment: .leading, spacing: 16) {
                Text("Email")
                TextField("yourname@example.com", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .email)
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
                
                Text("Password")
                SecureField("Your password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        login()
                    }
                
                HStack {
                    Spacer()
                    Button("Login") {
                        login()
                    }
                    Spacer()
                }
                
                // Answer to the question asked in the instructions: The keyboard may overlap with one of the input fields when the iPhone is in Landscape Mode, which can irritate the user and worsen the User Experience as they won't be able to check their input for typos. In the context of this submission, the usage of HStack and VStack avoids this inconvenience.
                
                if isLoading {
                    HStack {
                        Spacer()
                        ProgressView("Logging in...")
                        Spacer()
                    }
                }
                
                Spacer()
            }
            .frame(maxWidth: 500)
            .padding()
            .disabled(isLoading)
            Spacer()
        }
        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK", role: .cancel) {
                
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    private func login() {
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertTitle = "Missing Email"
            alertMessage = "Please enter your email address."
            showAlert = true
            return
        }
        
        guard !password.isEmpty else {
            alertTitle = "Missing Password"
            alertMessage = "Please enter your password."
            showAlert = true
            return
        }
        
        focusedField = nil
        isLoading = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if email == "test@example.com" && password == "password123" {
                alertTitle = "Success"
                alertMessage = "Login successful."
            } else {
                alertTitle = "Login Failed"
                alertMessage = "Email or password is incorrect."
            }
            isLoading = false
            showAlert = true
        }
    }
}

#Preview {
    ContentView()
}
