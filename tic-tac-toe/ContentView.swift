//
//  ContentView.swift
//  tic-tac-toe
//
//  Created by Lê Minh An on 26/03/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var endGameContext = "Tic-Tac-Toe"
    @State private var gameTitle = "Tic-Tac-Toe"
    @State private var isGameBoardDisable = false
//    @State private var endGameState = false
//    @State private var isHumanTurn = true
    @State private var alertItem: AlertItem?
    private var ranges = [(0...2), (3...5), (6...8)]
    
    
    var body: some View {
        VStack {
            Text(gameTitle)
            
            Spacer()
            
            ForEach(ranges, id: \.self) { range in
                HStack {
                    ForEach(range, id: \.self) { i in
                        XOButton(letter: moves[i]?.indicator ?? "")
                            .simultaneousGesture(
                            TapGesture()
                                .onEnded { _ in
                                    if isCircleChecked(in: moves, forIndex: i) {
                                        return
                                    }
//                                    playerTap(index: i)
                                    moves[i] = Move(player: .human, boardIndex: i)
//                                    isHumanTurn.toggle()
                                    
                                    
                                    // Check end game state
                                    if checkWinner(for: .human, in: moves) {
                                        endGameContext = "You has won!"
                                        alertItem = AlertContext.humanWin
                                        return
                                    }
                                    
                                    if checkDraw(in: moves) {
                                        endGameContext = "Draw"
                                        alertItem = AlertContext.draw
                                        return
                                    }
                                    
                                    isGameBoardDisable = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        let botMove = botMove(in: moves)
                                        moves[botMove] = Move(player: .bot, boardIndex: botMove)
                                        isGameBoardDisable = false
                                        
                                        if checkWinner(for: .bot, in: moves){
                                            endGameContext = "Computer has won!"
                                            alertItem = AlertContext.botWin
                                            return
                                        }
                                        if checkDraw(in: moves) {
                                            alertItem = AlertContext.draw
                                            return
                                        }
                                    }
                                    
                                    
                                }
                            )
                    }
                }
            }
            
            Spacer()
            
            Button("Reset", action: resetGame)
        }
        .disabled(isGameBoardDisable)
        .alert(item: $alertItem, content: { alertItem in
            Alert(title: alertItem.title, message: alertItem.message,
                  dismissButton: .default(alertItem.buttonTitle, action: { resetGame() }))
        })
    }
    
    func resetGame(){
        moves = Array(repeating: nil, count: 9)
    }
}

enum Player {
    case human, bot
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "X" : "O"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
