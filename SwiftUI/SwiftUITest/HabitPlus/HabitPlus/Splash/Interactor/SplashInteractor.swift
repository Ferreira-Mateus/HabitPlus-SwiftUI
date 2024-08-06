import Foundation
import Combine

class SplashInteractor {
    
    private let local: LocalDataSource = .shared
}

extension SplashInteractor {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return local.getUserAuth()
    }
}

