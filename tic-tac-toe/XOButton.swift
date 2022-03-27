//
//  XOButton.swift
//  tic-tac-toe
//
//  Created by Lê Minh An on 26/03/2022.
//

import SwiftUI

struct XOButton: View {
    @Binding var letter: String
    @State private var degrees = 0.0
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: getWidth(), height: getWidth())
                .foregroundColor(.blue)
            Circle()
                .frame(width: getWidth() - 20, height: getWidth() - 20)
                .foregroundColor(.white)
            Text(letter)
                .font(.system(size: 50))
                .bold()
        }
        .rotation3DEffect(.degrees(degrees), axis: (x: 0, y: 1, z: 0))
        .simultaneousGesture(
        TapGesture()
            .onEnded { _ in
                withAnimation(.easeIn(duration: 0.25)) {
                    self.degrees -= 180
                }
                
            }
        )
    }
    
    func getWidth()->CGFloat {
        
        // Horrizontal padding = 30
        // spacing = 30
        let width = UIScreen.main.bounds.width - (30+30)
        
        return width / 3
    }
        
}

struct XOButton_Previews: PreviewProvider {
    static var previews: some View {
        XOButton(letter: .constant("X"))
        
    }
}
