//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Mateus Andrade on 01/03/24.
//

import SwiftUI

struct ContentView: View {
    // AULA 2 - STATE
    // Com o @State, ela se torna uma variavel de estado de interface grafica
    @State var show = false
    // TEM QUE ESCREVER ISSO RPA ELE ENTENDER QUE
    // É UM COMPONENTE DE INTERFACE GRAFICA DO SWIFTUI
    var body: some View {
        // AQUI DENTRO ESCREVEMOS OS COMPONENTES
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
//            Text("Hello, aaaabc")
            Button {
                show.toggle()
                // Toggle é uma chave onde se a var ta falso fica verdadeiro e se esta verdadeiro fica falso
                print("cliquei")
            } label: {
                Text("Entrar")
            }
            
            // AULA 2
            if show {
                Text("Bem vindo")
            }
            
            // AULA 3
            VStack {
                // Vertical Stack
                Text("1")
                    .foregroundStyle(.brown)
                Text("2")
                    .foregroundStyle(.brown)
                Button {
                    print("oi")
                } label: {
                    Text("Button 1")
                        .foregroundColor(.brown)
                }
            }
            
            HStack {
                // Horizontal Stack
                Spacer()
                
                Text("1")
                    .foregroundStyle(.red)
                
                Spacer()
                
                Text("2")
                    .foregroundStyle(.red)
                
                Spacer()
                
                Text("3")
                    .foregroundStyle(.red)
                
                Spacer()
                
            }
            
            HStack {
                // Horizontal Stack
                Text("1")
                    .foregroundStyle(.red)
                    .padding(30)
                
                Text("2")
                    .foregroundStyle(.red)
                    .padding(.horizontal, 30)
                
                Text("3")
                    .foregroundStyle(.red)

                
            }.padding(.vertical, 40)
            
            ZStack {
                // Um emcima do outro
                Text("1")
                    .foregroundStyle(.green)
                Text("2")
                    .foregroundStyle(.green)
                Button {
                    print("oi")
                } label: {
                    Text("Button 1")
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        
        // AULA 5
        VStack {
            Text("Aula 5 \(show)")
            Button {
                show = true
            } label: {
                Text("Binding")
            }
            // Esse $ é o binding, pois quando ele aperta o botão, aparece um ok para fechar
            .alert(isPresented: $show, content: {
                Alert(title: Text("Alerta Aparecer"))
            })
        }
        
        // Podemos usar a propriedade com o atributo logo em seguida
//        Text("Ola Mundo Matias")
//            .foregroundStyle(.blue)
//            .bold()
//            .font(.title)
//        
//        Text("Hey")
//            .italic()
//            .foregroundStyle(.red)
        // Isto é uma maneira declarativa
        // Diferente da imperativa que seria:
        // text = UILabel()
        // text.italic()
    }
}

// Visualizador da tela
// Se comentar a tela de visualização some
// Se você clicar no elemento na tela, ele mostra onde está no código
// No menu esquerdo inferior tem 3 icones, o de setinha, tem algumas opções de dark mode, orientação e etc
#Preview {
    ContentView()
}

// AULA 2 - STATES
// A tela do SwiftUI é como se estivesse dentro de um while, sendo criada a todo momento, então como fazer para modificar uma mensagem nova se ela esta atualziando toda hora (ex: digitar email e senha e dar uma aviso de senha errada?)


// AULA 3 - VSTACK e HSTACK
// VSTACK, HSTACK e ZSTACK

// AULA 4 - VIEWS E ESPAÇAMENTO
// Componente Spacer, é um componente para forçar uma margem, mas sem ser mostrado, apenas um espaço, literalmente
// Componente Padding

// AULA 5 - BINDINGS
// Mesclar, comunicar com outra coisa, imagine o exemplo, quero que quando apertar o botão, mostrar uma mensagem de alerta
