import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView()
    }
}
