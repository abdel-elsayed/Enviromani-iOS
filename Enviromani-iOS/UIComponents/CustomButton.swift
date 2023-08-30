//
//  CustomButton.swift
//  Enviromani-iOS
//
//  Created by Abdelrahman Elsayed on 8/30/23.
//

import SwiftUI

struct CustomButton: View {
@State var text = ""
@State private var didTap: Bool = false

  var body: some View {
      Button {
          self.didTap = true
      } label: {
          Text(text)
              .fontWeight(.bold)
              .foregroundColor(Color("darkGreen"))
              .font(.title3)
              .padding(.horizontal, 15)
              .padding(.vertical, 10)
      }
      .buttonStyle(.bordered)
      .foregroundColor(.green)
      .controlSize(.large)
      .overlay(
          RoundedRectangle(cornerRadius: 19)
              .stroke(Color.white, lineWidth: 3)
      )
      .tint(self.didTap ? Color("darkGreen") : .white)
  }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
