import Foundation

struct UserAuth: Codable {
    
    var idToken: String
    var refreshToken: String
    var expires: Double = 0.0
    var tokeyType: String

    enum CodingKeys: String, CodingKey {
        case idToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokeyType = "token_type"
    }
}
