//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Lê Minh An on 26/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["", "", "", "", "", "", "", "", ""]
    @State private var endGameContext = "Tic-Tac-Toe"
    @State private var endGameState = false
    private var ranges = [(0...2), (3...5), (6...8)]
    
    var body: some View {
        VStack {
            Text(endGameContext)
                .alert(endGameContext, isPresented: $endGameState) {
                    Button("Reset", role: .destructive, action: resetGame)
                }
            
            Spacer()
            
            ForEach(ranges, id: \.self) { range in
                HStack {
                    ForEach(range, id: \.self) { i in
                        XOButton(letter: $moves[i])
                            .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    playerTap(index: i)
                                }
                            )
                    }
                }
            }
            
            Spacer()
            
            Button("Reset", action: resetGame)
        }
    }
    
    func playerTap(index: Int){
        if moves[index] == "" {
            moves[index] = "X"
            botMove()
        }
        
        // Check won
        for letter in ["X", "O"] {
            if checkWinner(list: moves, letter: letter) {
                endGameContext = "\(letter) has won!"
                endGameState = true
                break
            }
        }
    }
    
    func botMove(){
        var availableMoves: [Int] = []
        var movesLeft = 0
        
        for move in moves {
            if move == "" {
                availableMoves.append(movesLeft)
            }
            movesLeft += 1
        }
        
        if availableMoves.count != 0 {
            moves[availableMoves.randomElement()!] = "O"
        }
    }
    
    func resetGame(){
        endGameContext = "Tic-Tac-Toe"
        moves = ["", "", "", "", "", "", "", "", ""]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
