import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @State private var username = String()
    @State private var password = String()
    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .padding()
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
        
            Button(action: {
                viewModel.registerUser(user: AuthenticationModel(email: username,
                                                                 password: password))
                
            }, label: {
                Text("Register")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }).padding()
            
            NavigationLink(destination: InspectionViewControllerRepresentable(),isActive: $viewModel.isSuccess){
                EmptyView()
            }
        }
    }
}

#Preview {
    RegisterView()
}
