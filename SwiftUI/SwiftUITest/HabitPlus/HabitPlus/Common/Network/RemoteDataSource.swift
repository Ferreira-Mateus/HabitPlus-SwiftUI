import Foundation

class RemoteDataSource {
    
    // Padrão Singleton
    // Vamos ter uma única instância, ou um unico objeto vivo dele dentro da aplicação
    
    // construtor privado, para evitar um new RemoteDataSource
    // o único jeto de ter acesso a essa classe seria uma variavel compartilhada quen vai ser o shared
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init() { }
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        WebService.call(path: .login,
             params: [URLQueryItem(name: "username", value: request.email),
                      URLQueryItem(name: "password", value: request.password)
                     ]) { result in
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .unauthorized {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        completion(nil, response)
                    }
                }
                break
            case .success(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
            }
        }
    }
}
