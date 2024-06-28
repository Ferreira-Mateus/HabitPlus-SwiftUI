import Foundation

// 
enum Gender: String, CaseIterable, Identifiable {
    case masc = "Masculino"
    case fem = "Feminino"
    case other = "Outro"
    
    var id: String {
        self.rawValue
    }
    
    var index: Self.AllCases.Index {
        // Pegando o primeiro indice
        return Self.allCases.firstIndex { self == $0 } ?? 0
    }
}
