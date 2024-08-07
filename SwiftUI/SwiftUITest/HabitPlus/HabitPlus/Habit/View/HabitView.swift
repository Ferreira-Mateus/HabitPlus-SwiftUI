import Foundation
import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    var body: some View {
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                
                progress
            } else if case HabitUIState.emptyList = viewModel.uiState {
                
                
            } else if case HabitUIState.fullList = viewModel.uiState {
                
                
            } else {
                
                
            }
        }
    }
}

extension HabitView {
    
    var progress: some View {
        ProgressView()
    }
}

#Preview {
    HomeViewRouter.makeHabitView()
}
