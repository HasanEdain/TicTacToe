//
//  MachineMove.swift
//  TicTacToe
//
//  Created by Hasan Edain on 6/22/21.
//

import Foundation

struct MachineMove {
    static func randomMove(player: TileState, board: Board) -> Bool {
        if board.noneEmpty() == true {
            return false
        }
        var hasMoved = false
        
        while hasMoved != true {
            let dice = Int.random(in: 0..<board.tiles.count)
            if board.canMove(index: dice) {
                board.move(player: player, index: dice)
                hasMoved = true
            }
        }
        
        return hasMoved
    }
    
    static func heuristicMove(player: TileState, board: Board) -> Bool {
        if board.emptyCount() == 7 {
            return firstMoveHeuristic(player: player,board: board)
        }
        
        var opponentPlayer: TileState
        if player == .playerX {
            opponentPlayer = .playerO
        } else {
            opponentPlayer = .playerX
        }
        
        if let index = board.firstBlockIndex(player: opponentPlayer) {
            board.move(player: player, index: index)
            return true
        }
        
        if let index = board.firstLineIndex(player: player) {
            board.move(player: player, index: index)
            return true
        }
        
        return firstMoveHeuristic(player: player, board: board)
    }
    
    static func firstMoveHeuristic(player: TileState, board: Board) -> Bool {
        if board.noneEmpty() == true {
            return false
        }
        
        var hasMoved = false
        
        if board.canMove(index: 4) {
            board.move(player: player, index: 4)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 0) {
            board.move(player: player, index: 0)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 2) {
            board.move(player: player, index: 2)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 6) {
            board.move(player: player, index: 6)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 8) {
            board.move(player: player, index: 8)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 1) {
            board.move(player: player, index: 1)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 3) {
            board.move(player: player, index: 3)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 5) {
            board.move(player: player, index: 5)
            hasMoved = true
        }
        
        if hasMoved == false && board.canMove(index: 7) {
            board.move(player: player, index: 7)
            hasMoved = true
        }
        
        return hasMoved
    }
}
