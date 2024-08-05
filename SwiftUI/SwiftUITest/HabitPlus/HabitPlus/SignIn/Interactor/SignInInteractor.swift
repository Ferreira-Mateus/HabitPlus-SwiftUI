import Foundation

class SignInInteractor {
    
    // Seria o repository essa classe
    // o remote e o local seria o tipo de chamada que vamos usar
    private let remote: RemoteDataSource = .shared
//    private let local: LocalDataSource
}

extension SignInInteractor {
    
    func login(loginRequest request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        remote.login(request: request, completion: completion)
    }
}
