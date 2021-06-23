//
//  Tile.swift
//  TicTacToe
//
//  Created by Hasan Edain on 6/22/21.
//

import SwiftUI

struct Tile: View {
    @Binding var tileState: TileState
    var index: Int
    
    let tileSize: CGFloat = 100
    
    var body: some View {
        switch tileState {
        case .empty:
            Image("Empty")
                .resizable()
                .frame(width: tileSize, height: tileSize)
        case .playerX:
            Image("PlayerX")
                .resizable()
                .frame(width: tileSize, height: tileSize)
        case .playerO:
            Image("PlayerO")
                .resizable()
                .frame(width: tileSize, height: tileSize)
        }
    }
}

struct Tile_Previews: PreviewProvider {
    @State static var empty: TileState = .empty
    @State static var playerX: TileState = .playerX
    @State static var playerO: TileState = .playerO
    static var indexZero = 0
    static var indexOne = 1
    static var indexTwo = 2
    
    static var previews: some View {
        VStack {
            Tile(tileState: $empty, index: indexZero)
            Tile(tileState: $playerX, index: indexOne)
            Tile(tileState: $playerO, index: indexTwo)
        }
        
    }
}
