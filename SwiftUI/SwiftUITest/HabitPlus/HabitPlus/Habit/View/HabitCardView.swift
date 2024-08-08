import SwiftUI

struct HabitCardView: View {
    
    @State private var action = false
    
    let viewModel: HabitCardViewModel
    
    var body: some View {
        ZStack(alignment: .trailing) {
            NavigationLink(destination: Text("Destination"),
                           isActive: self.$action,
                           label: {
                EmptyView()
            })
            
            Button(action: {
                self.action = true
            }, label: {
                HStack {
                    Image(systemName: "pencil")
                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.name)
                                .foregroundColor(.blue)
                            
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            
                            Text(viewModel.date)
                                .foregroundColor(Color("textColor"))
                                .bold()
                        }.frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Registrado")
                                .foregroundColor(.blue)
                                .bold()
                                .multilineTextAlignment(.leading)
                            
                            Text(viewModel.value)
                                .foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding()
                .cornerRadius(4.0)
            })
            
            Rectangle()
                .frame(width: 8)
                .foregroundColor(viewModel.state)
        }
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(Color.blue, lineWidth: 1.4)
                .shadow(color: .gray, radius: 2, x: 2.0, y: 2.0)
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationView {
        List {
            let model = HabitCardViewModel(id: 1,
                                           icon: "teste",
                                           date: "01/01/2021 00:00:00",
                                           name: "Tocar Guitarra",
                                           value: "2",
                                           state: .green)
            HabitCardView(viewModel: model)
            
            let model2 = HabitCardViewModel(id: 1,
                                            icon: "teste",
                                            date: "01/01/2021 00:00:00",
                                            name: "Tocar Guitarra",
                                            value: "2",
                                            state: .red)
            
            HabitCardView(viewModel: model2)
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Teste")
    }
    
}
