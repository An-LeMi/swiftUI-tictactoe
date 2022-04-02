//
//  Utils.swift
//  tic-tac-toe
//
//  Created by Lê Minh An on 26/03/2022.
//

import Foundation

func checkWinner(for player: Player, in moves: [Move?]) -> Bool {
    let winningSequences: Set<Set<Int>> = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 4, 8], [2, 4, 6],
        [0, 3, 6], [1, 4, 7], [2, 5 ,8]
    ]
    
    let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
    let playerPositions = Set(playerMoves.map { $0.boardIndex })
    
    for sequence in winningSequences where sequence.isSubset(of: playerPositions) {
        return true
    }
    return false
    
}

func checkDraw(in moves: [Move?]) -> Bool {
    return moves.compactMap { $0 }.count == 9
}

func botMove(in moves: [Move?]) -> Int {
    // If bot can win
    let winningSequences: Set<Set<Int>> = [
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        [0, 4, 8], [2, 4, 6],
        [0, 3, 6], [1, 4, 7], [2, 5 ,8]
    ]
    
    let botMoves = moves.compactMap { $0 }.filter { $0.player == .bot }
    let botPositions = Set(botMoves.map { $0.boardIndex })
    
    for sequence in winningSequences {
        let winPositions = sequence.subtracting(botPositions)
        if winPositions.count == 1 {
            let isAvailable = !isCircleChecked(in: moves, forIndex: winPositions.first!)
            if isAvailable {
                return winPositions.first!
            }
        }
        
    }
    
    // If human can win, block
    let playerMoves = moves.compactMap { $0 }.filter { $0.player == .human }
    let playerPositions = Set(playerMoves.map { $0.boardIndex })
    
    for sequence in winningSequences {
        let winPositions = sequence.subtracting(playerPositions)
        
        if winPositions.count == 1 {
            let isAvailable = !isCircleChecked(in: moves, forIndex: winPositions.first!)
            if isAvailable {
                return winPositions.first!
            }
        }
    }
    // If bot can't block, take the middle
    let center = 4
    if !isCircleChecked(in: moves, forIndex: center) {
        return center
    }

    
    // Take random
    var randomPosition: Int
    
    repeat {
        randomPosition = Int.random(in: 0...8)
    }
    while isCircleChecked(in: moves, forIndex: randomPosition)
            
    return randomPosition
}

// Can't change letter in checked box
func isCircleChecked(in move: [Move?], forIndex index: Int) -> Bool {
    return move.contains(where: { $0?.boardIndex == index})
}


