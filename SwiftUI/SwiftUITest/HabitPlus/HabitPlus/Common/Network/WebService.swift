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
    
    static func postUser(fullName: String,
                         email: String,
                         password: String,
                         document: String,
                         phone: String,
                         birthday: String,
                         gender: Int) {
        
        let json: [String : Any] = [
            "name": fullName,
            "email": email,
            "document": password,
            "phone": phone,
            "gender": gender,
            "birthday": birthday,
            "password": password
        ]
        
        // try? pois vai tentar fazer essa conversão
        // caso queira tratar o erro, usar o do try catch
        // agora ele transforma nosso dicionário em um objeto json
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard var urlRequest = completeUrl(path: .postUser) else { return }
        
        // DEFINIÇÕES DA URL DE CHAMADA
        urlRequest.httpMethod = "POST"
        
        //Accept é o metodo que o cliente aceita, no caso aplication json
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                // Printando erro da url
                print(error)
                return
            }
            
            // Printando os dados que vão vir do response
            print(String(data: data, encoding: .utf8))
            print("response\n")
            print(response)
            
            // Transformando o response em httpStatusCode
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
        }
        
        task.resume()
    }
}
