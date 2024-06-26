import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("Home")
    }
}

let viewModelHome = HomeViewModel()
let splashHome = HomeView(viewModel: viewModelHome)

#Preview {
    splashHome
}
