//
//  WelcomeScreenView.swift
//  Enviromani-iOS
//
//  Created by Abdelrahman Elsayed on 8/30/23.
//

import SwiftUI

struct WelcomeScreenView: View {
    var body: some View {
        ZStack {
            Color("lightGreen").ignoresSafeArea()
            VStack(alignment: .center, content: {
                Image("WelcomeScreen")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.white, lineWidth: 3)
                    )
                Spacer()
                
                VStack(spacing: 15) {
                    Text("Enviromania")
                        .font(.custom(
                            "AmericanTypewriter",
                            fixedSize: 34)
                            .weight(.black)
                        )
                    .fontWeight(.bold)
                    Text("Connect and act with fellow environmental enthusiasts on a platform dedicated to making a sustainable impact.")
                        .font(.body)
                }
                .multilineTextAlignment(.center)
                .foregroundColor(Color("darkGreen"))
         
                Spacer()
                
                HStack(spacing: 30) {
                    CustomButton(text: "Register")
                    CustomButton(text: "Sign In")
                }
            })
        .padding(10)
        }
    }
}


struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
