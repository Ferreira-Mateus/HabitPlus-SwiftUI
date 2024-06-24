import Foundation

// Camada de modelo de dados que vai ser transposto para ViewModel
// Variáveis que são observadas pela ViewModel
// Exemplo o Youtuber é um viewModel, pois as pessoas observam ele, ele é observável
// Os observadores são os inscritos, são a view, são avisados quando o estado muda, quando algum video é lançado
enum SplashUIState {
    case loading
    case goToSigningScreen
    case goToHomeScreen
    case error(String)
}
