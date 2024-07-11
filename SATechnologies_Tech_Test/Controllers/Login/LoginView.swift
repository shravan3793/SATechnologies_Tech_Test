
import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var username = ""
    @State private var password = ""
    @State private var navigateToRegister = false
    var body: some View {
        NavigationView {
            VStack {
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    viewModel.callLoginApi(user: AuthenticationModel(email: username, password: password))
                }) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
                
                Button(action: {
                    navigateToRegister = true
                    
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(Edge.Set(arrayLiteral: .leading, .trailing))
                
                if !viewModel.statusMessage.isEmpty {
                    Text(viewModel.statusMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                NavigationLink(destination: InspectionViewControllerRepresentable(), isActive: $viewModel.isAuthenticationSuccess) {
                    EmptyView()
                }
                
                NavigationLink(destination: RegisterView(),isActive: $navigateToRegister) {
                }
            }
        }
        .alert(isPresented: .constant(!viewModel.statusMessage.isEmpty)) {
            Alert(title: Text("Error"), message: Text(viewModel.statusMessage), dismissButton: .default(Text("OK")))
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct InspectionView: View {
    var body: some View {
        Text("Inspection View")
            .navigationTitle("Inspection")
    }
}
