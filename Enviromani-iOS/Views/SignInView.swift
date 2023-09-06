//
//  SignInView.swift
//  Enviromani-iOS
//
//  Created by Abdelrahman Elsayed on 9/1/23.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
   
    var body: some View {
        ZStack {
            Color("lightGreen").ignoresSafeArea()
            VStack(spacing: 20) {
                Text("Login")
                    .font(.system(size: 34.0,
                                  weight: .regular,
                                  design: .rounded))
//                    .font(.custom(
//                        "SanFrancisco",
//                        fixedSize: 34)
//                        .weight(.black)
//                    )
//                    .foregroundColor(Color("darkGreen"))
                    .fontWeight(.bold)
                    .padding(.vertical, 30)
                
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
                        .bold()
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
                .padding(.bottom, 30)
                
                Divider()
                
                HStack(spacing: 30) {
                    Image("facebook")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .onTapGesture {
                            // sing in
                        }
                    
                    Image("google")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .onTapGesture {
                            // sing in
                        }
                    
                    Image("apple")
                        .resizable()
                        .frame(width: 55, height: 55)
                        .onTapGesture {
                            // sing in
                        }
                }
                .padding(.bottom, 10)
            }
            .background(Color.white.opacity(0.4).cornerRadius(10))
            .padding(.horizontal, 10)
            .font(.system(size: 20))
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
