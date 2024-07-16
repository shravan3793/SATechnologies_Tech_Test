import Foundation
import Combine

/// Enum representing different login statuses.
enum LoginStatus: String {
    /// Unknown error message.
    case unknownError = "Unknown Error"
}

/// ViewModel responsible for handling login logic.
class LoginViewModel {
    
    /// Publishes a boolean indicating whether authentication was successful.
    var isAuthenticationSuccess = PassthroughSubject<Bool, Never>()
    
    /// Publishes status messages from the login process.
    var statusMessage = PassthroughSubject<String?, Never>()
    
    /// Stores Combine cancellables.
    private var cancellables = Set<AnyCancellable>()
    
    /// Initializes the LoginViewModel and sets up bindings.
    init() {
        setupBindings()
    }
    
    /// Sets up bindings to listen for changes in the API response model.
    private func setupBindings() {
        APIManager.shared.responseModel
            .receive(on: DispatchQueue.main) // Ensure updates are received on the main thread
            .sink { [weak self] response in
                guard let self = self, let response = response else { return }
                self.handleResponseModel(response)
            }
            .store(in: &cancellables)
    }
    
    /// Calls the login API with the provided user credentials.
    /// - Parameter user: The user's authentication model containing login credentials.
    func callLoginApi(user: AuthenticationModel) {
        Task {
            do {
                try await APIManager.shared.request(endPoint: .login, userInput: user)
            } catch {
                self.statusMessage.send(LoginStatus.unknownError.rawValue)
            }
        }
    }
    
    /// Handles the API response model and updates the appropriate publishers.
    /// - Parameter response: The response model from the API call.
    private func handleResponseModel(_ response: ResponseModel?) {
        guard let status = response?.status else { return }
        switch status {
        case 200:
            self.isAuthenticationSuccess.send(true)
        case 400, 401:
            self.statusMessage.send(response?.error)
        default:
            self.statusMessage.send(LoginStatus.unknownError.rawValue)
        }
    }
}
