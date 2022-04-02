//
//  Alerts.swift
//  tic-tac-toe
//
//  Created by Lê Minh An on 01/04/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You Won!"),
                             message: Text("Excellent"),
                             buttonTitle: Text("Reset Game"))
    static let botWin = AlertItem(title: Text("You Lost!"),
                           message: Text("Better luck next time !!"),
                           buttonTitle: Text("Try again"))
    static let draw = AlertItem(title: Text("Draw!"),
                         message: Text("Just need a little more luck"),
                         buttonTitle: Text("Reset Game"))
    
    
}

