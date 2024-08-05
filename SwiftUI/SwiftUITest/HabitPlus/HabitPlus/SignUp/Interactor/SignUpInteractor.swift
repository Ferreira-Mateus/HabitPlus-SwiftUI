import Foundation
import Combine

class SignUpInteractor {
    
    private let remote: SignUpRemoteDataSource = .shared
    private let remoteSignIn: SignInRemoteDataSource = .shared
//    private let local: LocalDataSource
}

extension SignUpInteractor {
    
    func postUser(signUpRequest request: SignUpRequest) -> Future<Bool, AppError> {
        return remote.postUser(request: request)
    }
    
    func login(signInRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        return remoteSignIn.login(request: request)
    }
}
