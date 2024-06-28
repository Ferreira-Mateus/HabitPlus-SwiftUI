import Foundation

struct SignUpRequest: Encodable {
    
    var fullName: String
    var email: String
    var password: String
    var document: String
    var phone: String
    var birthday: String
    var gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case email
        case password
        case document
        case phone
        case birthday
        case gender
    }
}
