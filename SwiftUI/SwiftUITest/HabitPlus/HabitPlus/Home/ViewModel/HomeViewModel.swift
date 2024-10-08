import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = HabitViewModel(interactor: HabitInteractor())
}

extension HomeViewModel {
    func habitView() -> some View {
        return HomeViewRouter.makeHabitView(viewModel: viewModel)
    }
}
