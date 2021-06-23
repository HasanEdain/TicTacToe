//
//  Board.swift
//  TicTacToe
//
//  Created by Hasan Edain on 6/22/21.
//

import SwiftUI

class Board:ObservableObject {
    @Published var tiles: [TileState]
    
    init(tiles: [TileState] = [.empty,.empty,.empty,
                               .empty,.empty,.empty,
                               .empty,.empty,.empty]) {
        self.tiles = tiles
    }
    
    func canMove(index: Int) -> Bool {
        guard index >= 0 else {
            return false
        }
        
        guard index < tiles.count else {
            return false
        }
        
        if tiles[index] == .empty {
            return true
        }
        
        return false
    }
    
    func move(player: TileState, index: Int) {
        guard index >= 0 else {
            return
        }
        guard index < tiles.count else {
            return
        }
        guard(tiles[index] == .empty) else {
            return
        }
        
        tiles[index] = player
    }
    
    func playerWon(player: TileState) -> Bool {
        
        //Horizontal Top Line
        if tiles[0] == player && tiles[1] == player && tiles[2] == player {
            return true
        }

        //Horizontal Middle Line
        if tiles[3] == player && tiles[4] == player && tiles[5] == player {
            return true
        }

        //Horizontal Bottom Line
        if tiles[6] == player && tiles[7] == player && tiles[8] == player {
            return true
        }
        
        //Vertical Left Line
        if tiles[0] == player && tiles[3] == player && tiles[6] == player {
            return true
        }

        //Vertical Middle Line
        if tiles[1] == player && tiles[4] == player && tiles[7] == player {
            return true
        }

        //Vertical Right Line
        if tiles[2] == player && tiles[5] == player && tiles[8] == player {
            return true
        }
        
        // Diagonal TL to BR
        if tiles[0] == player && tiles[4] == player && tiles[8] == player {
            return true
        }
        
        // Diagonal TR to BL
        if tiles[2] == player && tiles[4] == player && tiles[6] == player {
            return true
        }

        return false
    }
    
    func firstBlockIndex(player: TileState) -> Int? {
        // Diagonal TL to BR
        if tiles[0] == player && tiles[4] == player && tiles[8] == .empty {
            return 8
        }
        
        if tiles[0] == .empty && tiles[4] == player && tiles[8] == player {
            return 0
        }
        
        if tiles[0] == player && tiles[4] == .empty && tiles[8] == player {
            return 4
        }
        
        // Diagonal TR to BL
        if tiles[2] == player && tiles[4] == .empty && tiles[6] == player {
            return 4
        }
        
        if tiles[2] == .empty && tiles[4] == player && tiles[6] == player {
            return 2
        }
        
        if tiles[2] == player && tiles[4] == player && tiles[6] == .empty {
            return 6
        }
        
        // Vertical Left Column
        if tiles[0] == .empty && tiles[3] == player && tiles[6] == player {
            return 0
        }
        
        if tiles[0] == player && tiles[3] == .empty && tiles[6] == player {
            return 3
        }
        
        if tiles[0] == player && tiles[3] == player && tiles[6] == .empty {
            return 6
        }
        
        // Vertical middle Column
        if tiles[1] == .empty && tiles[4] == player && tiles[7] == player {
            return 1
        }
        
        if tiles[1] == player && tiles[4] == .empty && tiles[7] == player {
            return 4
        }
        
        if tiles[1] == player && tiles[4] == player && tiles[7] == .empty {
            return 7
        }
        
        // Vertical right Column
        if tiles[2] == .empty && tiles[5] == player && tiles[8] == player {
            return 2
        }
        
        if tiles[2] == player && tiles[5] == .empty && tiles[8] == player {
            return 5
        }
        
        if tiles[2] == player && tiles[5] == player && tiles[8] == .empty {
            return 8
        }
        
        // Horizontal top column
        if tiles[0] == player && tiles[1] == player && tiles[2] == .empty {
            return 2
        }
        
        if tiles[0] == player && tiles[1] == .empty && tiles[2] == player {
            return 1
        }
        
        if tiles[0] == .empty && tiles[1] == player && tiles[2] == player {
            return 0
        }
        
        // Horizontal middle column
        if tiles[3] == player && tiles[4] == player && tiles[5] == .empty {
            return 5
        }
        
        if tiles[3] == player && tiles[4] == .empty && tiles[5] == player {
            return 4
        }
        
        if tiles[3] == .empty && tiles[4] == player && tiles[5] == player {
            return 3
        }
        
        // Horizontal bottom column
        if tiles[6] == player && tiles[7] == player && tiles[8] == .empty {
            return 8
        }

        if tiles[6] == player && tiles[7] == .empty && tiles[8] == player {
            return 7
        }

        if tiles[6] == .empty && tiles[7] == player && tiles[8] == player {
            return 6
        }
        
        return nil
    }
    
    func firstLineIndex(player: TileState) -> Int? {
        // Diagonal TL to BR
        if tiles[0] == player && tiles[4] == .empty && tiles[8] == .empty {
            return 4
        }
        
        if tiles[0] == .empty && tiles[4] == player && tiles[8] == .empty {
            return 0
        }
        
        if tiles[0] == .empty && tiles[4] == .empty && tiles[8] == player {
            return 4
        }
        
        // Diagonal TR to BL
        if tiles[2] == player && tiles[4] == .empty && tiles[6] == .empty {
            return 4
        }
        
        if tiles[2] == .empty && tiles[4] == .empty && tiles[6] == player {
            return 4
        }
        
        if tiles[2] == .empty && tiles[4] == player && tiles[6] == .empty {
            return 2
        }
        
        // Vertical Left Column
        if tiles[0] == .empty && tiles[3] == .empty && tiles[6] == player {
            return 0
        }
        
        if tiles[0] == player && tiles[3] == .empty && tiles[6] == .empty {
            return 6
        }
        
        if tiles[0] == .empty && tiles[3] == player && tiles[6] == .empty {
            return 0
        }
        
        // Vertical middle Column
        if tiles[1] == .empty && tiles[4] == .empty && tiles[7] == player {
            return 4
        }
        
        if tiles[1] == player && tiles[4] == .empty && tiles[7] == .empty {
            return 4
        }
        
        if tiles[1] == .empty && tiles[4] == player && tiles[7] == .empty {
            return 1
        }
        
        // Vertical right Column
        if tiles[2] == .empty && tiles[5] == .empty && tiles[8] == player {
            return 2
        }
        
        if tiles[2] == player && tiles[5] == .empty && tiles[8] == .empty {
            return 8
        }
        
        if tiles[2] == .empty && tiles[5] == player && tiles[8] == .empty {
            return 2
        }
        
        // Horizontal top column
        if tiles[0] == player && tiles[1] == .empty && tiles[2] == .empty {
            return 2
        }
        
        if tiles[0] == .empty && tiles[1] == .empty && tiles[2] == player {
            return 2
        }
        
        if tiles[0] == .empty && tiles[1] == player && tiles[2] == .empty {
            return 0
        }
        
        // Horizontal middle column
        if tiles[3] == player && tiles[4] == .empty && tiles[5] == .empty {
            return 4
        }
        
        if tiles[3] == .empty && tiles[4] == .empty && tiles[5] == player {
            return 4
        }
        
        if tiles[3] == .empty && tiles[4] == player && tiles[5] == .empty {
            return 3
        }
        
        // Horizontal bottom column
        if tiles[6] == player && tiles[7] == .empty && tiles[8] == .empty {
            return 8
        }

        if tiles[6] == .empty && tiles[7] == .empty && tiles[8] == player {
            return 6
        }

        if tiles[6] == .empty && tiles[7] == player && tiles[8] == .empty {
            return 6
        }
        
        return nil
    }
    
    func isTie() -> Bool {
        if playerWon(player: .playerO) == true {
            return false
        }
        if playerWon(player: .playerX) == true {
            return false
        }
        
        return noneEmpty()
    }
    
    func emptyCount() -> Int {
        var count = 0

        tiles.forEach { tile in
            if tile == .empty {
                count += 1
            }
        }

        return count
    }
    
    func noneEmpty() -> Bool {
        return emptyCount() == 0
    }
    
    func reset() {
        self.tiles = [.empty,.empty,.empty,
                      .empty,.empty,.empty,
                      .empty,.empty,.empty]
    }
}
