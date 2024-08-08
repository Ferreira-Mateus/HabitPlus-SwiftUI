import Foundation
import SwiftUI

class HabitViewModel: ObservableObject {
    
    @Published var uiState: HabitUIState = .emptyList
    
    @Published var title = "Atenção"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Você está atrasado nos hábitos"
    
    func onAppear() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            var rows: [HabitCardViewModel] = []
            
            rows.append(HabitCardViewModel(id: 1,
                                           icon: "teste",
                                           date: "01/01/2021 00:00:00",
                                           name: "Tocar Guitarra",
                                           label: "horas",
                                           value: "2",
                                           state: .green))
            
            rows.append(HabitCardViewModel(id: 2,
                                           icon: "teste",
                                           date: "01/01/2021 00:00:00",
                                           name: "Caminhada",
                                           label: "km",
                                           value: "2",
                                           state: .green))
            
            self.uiState = .error("errinho")
        }
    }
}
