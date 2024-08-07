import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    // Utilizando uma imagem ícone que foi desenvolvido pelos próprios designers da Apple que posso encontrar no app chamado, Symbols explorer
                    Image(systemName: "square.grid.2x2")
                    Text("Hábitos")
                }.tag(0)
            
            // Aqui o conteúdo
            Text("Conteúdo de gráficos \(selection)")
                .tabItem {
                    // Aqui no tabItem é a parte que indíca a page selecionada da tabBar
                    Image(systemName: "chart.bar")
                    Text("Gráficos")
                }.tag(1)
            
            Text("Perfil \(selection)")
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
        }
        .background(Color.white)
        .accentColor(Color.blue)
    }
}

let viewModelHome = HomeViewModel()
let splashHome = HomeView(viewModel: viewModelHome)

#Preview {
    splashHome
}
