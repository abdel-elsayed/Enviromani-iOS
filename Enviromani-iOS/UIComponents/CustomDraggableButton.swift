//
//  CustomDraggableButton.swift
//  RestartApp
//
//  Created by Abdelrahman Elsayed on 1/19/23.
//

import SwiftUI

struct CustomDraggableButton: View {
    let completion: () -> Void
    @State var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State var buttonOffset: CGFloat = 0
    @State var text: String
    @State var color: Color
    @State var isAnimating = false
    
    var body: some View {
        ZStack {
            Capsule()
                .fill(color.opacity(0.2))
            Capsule()
                .fill(color.opacity(0.2))
                .padding(8)
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(color)
                .offset(x: 20)
            
            backgroundColor

            HStack {
                draggableButton
                .offset(x: buttonOffset)
                .gesture(
                DragGesture()
                    .onChanged({ gesture in
                        if gesture.translation.width > 0 && gesture.translation.width <= buttonWidth - 80 {
                            buttonOffset = gesture.translation.width
                        }
                    })
                    .onEnded({ _ in
                        if buttonOffset > buttonWidth / 2 {
                            buttonOffset = buttonWidth - 80
                            completion()
                        } else {
                            buttonOffset = 0
                        }
                    })
                )
                Spacer()
            }
        }
        .offset(y: isAnimating ? 0 : 40)
        .opacity(isAnimating ? 1 : 0)
        .animation(.easeOut(duration: 1), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
        .frame(width: buttonWidth, height: 80, alignment: .center)
        .padding()
    }
    
    @ViewBuilder var backgroundColor: some View {
        HStack {
            Capsule()
                .fill(color)
            .frame(width: buttonOffset + 80)
            Spacer()
        }
    }
    
    @ViewBuilder var draggableButton: some View {
        ZStack {
            Circle()
                .fill(color)
            Circle()
                .fill(.black.opacity(0.2))
                .padding(8)
            Image(systemName: "chevron.right.2")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct CustomDraggableButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.black)
            CustomDraggableButton(completion: {},
                                  text: "Get Started",
                                  color: Color("ColorRed"))
            }
    }
}
