import SwiftUI

struct LoginView: View {
    @EnvironmentObject var auth: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Exibe a logo (certifique-se que a imagem "logo" esteja nos Assets)
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            // Campo para e‑mail
            TextField("E-mail", text: $email)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(8)
                .autocapitalization(.none)
            
            // Campo para senha (entrada segura)
            SecureField("Senha", text: $password)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(8)
            
            // Exibe mensagem de erro, se houver
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            
            // Botão de login
            Button(action: {
                auth.login(email: email, password: password)
            }) {
                Text("Entrar")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(
            // Fundo com gradiente
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthViewModel())
    }
}
