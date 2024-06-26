import Combine

//Sign
var cancellable: AnyCancellable?
let publisher = PassthroughSubject<Bool, Never>()

cancellable = publisher.sink { value in
    print(value)
} // callback
// signIn vai ficar escutando esse booleano mudar de estado

var p: PassthroughSubject<Bool, Never> = publisher

// depois de apertao o botão e o servidor retornar success
print("não enviou")
cancellable?.cancel()
p.send(true)
print("ja enviou")

//SignUp
