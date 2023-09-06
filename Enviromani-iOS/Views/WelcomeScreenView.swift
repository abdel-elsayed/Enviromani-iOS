//
//  WelcomeScreenView.swift
//  Enviromani-iOS
//
//  Created by Abdelrahman Elsayed on 8/30/23.
//

import SwiftUI

struct WelcomeScreenView: View {
    @State var showSignInFlow = false
    var body: some View {
        ZStack {
            Color("lightGreen").ignoresSafeArea()
            VStack(alignment: .center, content: {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                Spacer()
                
                VStack(spacing: 15) {
                    Spacer()
                    Text("Connect. Inspire. Take Action.")
                        .font(.custom(
                            "AmericanTypewriter",
                            fixedSize: 34)
                            .weight(.black)
                        )
                        .fontWeight(.bold)
                    Text("Join and act with fellow environmental enthusiasts on a platform dedicated to making a sustainable impact.")
                        .font(.body)
                    
                    Spacer()
                    
                    CustomDraggableButton(completion: {
                        DispatchQueue.main.async {
                            showSignInFlow = true
                        }
                    },
                                          text: "Let's get started",
                                          color: Color("darkGreen"))
                }
                .background(Color.white.opacity(0.4).cornerRadius(10))
                .cornerRadius(10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color("darkGreen"))
                Spacer()
            })
        .padding(10)
        }.sheet(isPresented: $showSignInFlow) {
            SignInView()
        }
    }
}


struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}
