import Foundation

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum HttpCases: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    // O tipo T é qualquer coisa que extenda do que passar no proximo
    // Ou seja, agora essa função pode ser reutilizada para outras chamadas, no caso esse do post, de path tem o do post, e o de body ele tem o request que é do tipo SignUpRequest, que extende do Encodable e aí faz parte do tipo T que é genérico
    private static func call<T: Encodable>(path: Endpoint, 
                                           body: T,
                                           completion: @escaping (Result) -> Void) {
        
        guard var urlRequest = completeUrl(path: path) else { return }

        guard let jsonData = try? JSONEncoder().encode(body) else { return }

        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let r = response as? HTTPURLResponse {
                switch r.statusCode {
                case 200:
                    completion(.success(data))
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                default:
                    break
                }
            }
        }
        task.resume()
    }
    
    // Temos que receber de volta o erro ou dado caso tenha sido sucesso a requisição
    static func postUser(request: SignUpRequest) {
        call(path: .postUser, body: request) { result in
            switch result {
            case .failure(let error, let data):
                break
            case .success(let data):
                break
            }
        }
    }
}
