//
//  TileState.swift
//  TicTacToe
//
//  Created by Hasan Edain on 6/22/21.
//

import Foundation

enum TileState {
    case empty
    case playerX
    case playerO
    
    var displayString: String {
        switch self {
        case .empty:
            return ""
        case .playerX:
            return "X"
        case .playerO:
            return "O"
        }
    }
}
