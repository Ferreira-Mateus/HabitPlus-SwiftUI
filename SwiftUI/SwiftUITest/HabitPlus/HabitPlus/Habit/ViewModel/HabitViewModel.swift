import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .loading
    
    
}
