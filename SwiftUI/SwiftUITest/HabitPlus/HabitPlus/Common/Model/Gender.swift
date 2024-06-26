import Foundation

// 
enum Gender: String, CaseIterable, Identifiable {
    case masc = "Masculino"
    case fem = "Feminino"
    case other = "Outro"
    
    var id: String {
        self.rawValue
    }
}
