import Foundation

// Vai ser um enum porque só vamos chamar os recursos de chamada dele
enum WebService {
    
    /*
     {
       "name": "string",
       "email": "string",
       "document": "string",
       "phone": "string",
       "gender": 0,
       "birthday": "2024-06-28",
       "password": "string"
     }
     */
    
    // Enum com todos os endpoints e baseUrl para fazer a chamada com a url certa
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
    }
    
    enum HttpCases: String {
        case post = "POST"
        case get = "GET"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    // Função para retornar a URLRequest com o path que escolhermos
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }

        return URLRequest(url: url)
    }
    
    static func postUser(request: SignUpRequest) {
                
        guard let jsonData = try? JSONEncoder().encode(request) else { return }
        
        guard var urlRequest = completeUrl(path: .postUser) else { return }
        
        urlRequest.httpMethod = "POST"
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            
            print(String(data: data, encoding: .utf8))
            print("response\n")
            print(response)
            
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
        }
        
        task.resume()
    }
}
