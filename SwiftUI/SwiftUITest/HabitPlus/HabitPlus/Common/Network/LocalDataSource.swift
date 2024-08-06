import Foundation
import Combine

class LocalDataSource {
    // Gravar, ler e remover objeto dentro do banco de dados
    
    static var shared: LocalDataSource = LocalDataSource()
    
    private init() {}
    
    // Gravação
    private func saveValue(value: UserAuth) {
        // setValue salva o json
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: "user_key")
    }
    
    // Leitura
    private func readValue(forKey key: String) -> UserAuth {
        var userAuth: UserAuth?
        
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        return userAuth ?? UserAuth(idToken: "",
                                    refreshToken: "",
                                    expires: 0,
                                    tokeyType: "")
    }
}

extension LocalDataSource {
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(forKey: "user_key")
        
        return Future { promise in
            promise(.success(userAuth))
        }
    }
}
