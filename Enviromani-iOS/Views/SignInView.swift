//
//  SignInView.swift
//  Enviromani-iOS
//
//  Created by Abdelrahman Elsayed on 9/1/23.
//
import CryptoKit
import SwiftUI
import _AuthenticationServices_SwiftUI
import FirebaseAuth

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var currentNonce = ""
   
    var body: some View {
        ZStack {
//            Color("lightGreen").ignoresSafeArea()
            VStack() {
                Text("Login")
                    .font(.system(size: 34.0,
                                  weight: .regular,
                                  design: .rounded))
                    .fontWeight(.bold)
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .foregroundColor(Color("darkGreen"))
                    .textFieldStyle(.plain)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.gray)
                    
                    TextField("Password", text: $password)
                        .foregroundColor(Color("darkGreen"))
                        .textFieldStyle(.plain)
                    
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Button {
                    // sign IN
                } label: {
                    Text("Sign In")
                        .frame(width: 200, height: 40)
                        .background{
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color("darkGreen"))
                        }
                        .foregroundColor(Color("lightGreen"))
                }.padding(.top, 30)
                
                Button {
                    // sign IN
                } label: {
                    HStack {
                        Text("New to our world?") +
                        Text(" Sign Up now!").bold().font(Font.system(size: 18))
                    }
                    .fixedSize()
                    .font(Font.system(size: 16))
                    .frame(width: 200, height: 40)
                    .foregroundColor(Color("darkGreen"))
                }
                
                Divider()
                    .frame(width: 300, height: 1)
                    .overlay(.gray)
                                
                SignInWithAppleButton(.continue,
                                      onRequest: { request in
                    request.requestedScopes = [.email, .fullName]
                    let nonceString = randomNonceString()
                    currentNonce = nonceString
                    request.nonce = sha256(nonceString)
                }, onCompletion: { result in
                    if case .failure(let failure) = result {
                        fatalError(failure.localizedDescription)
                    }
                    else if case .success(let authorization) = result {
                        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                            guard let nonce = currentNonce else {
                                fatalError("Invalid state: a login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                print("Unable to fetdch identify token.")
                                return
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                            
                            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                                      idToken: idTokenString,
                                                                      rawNonce: nonce)
                            Task {
                                do {
                                    let result = try await Auth.auth().signIn(with: credential)
                                    await updateDisplayName(for: result.user, with: appleIDCredential)
                                }
                                catch {
                                    print("Error authenticating: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }).frame(width: 200, height: 40)
                    .cornerRadius(10)

                
//                .padding(.bottom, 10)
            }
            .padding(.horizontal, 10)
            .font(.system(size: 20))
            
        }
    }
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }

                                      private func sha256(_ input: String) -> String {
                                        let inputData = Data(input.utf8)
                                        let hashedData = SHA256.hash(data: inputData)
                                        let hashString = hashedData.compactMap {
                                          String(format: "%02x", $0)
                                        }.joined()

                                        return hashString
                                      }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
