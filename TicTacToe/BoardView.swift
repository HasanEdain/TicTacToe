//
//  BoardView.swift
//  TicTacToe
//
//  Created by Hasan Edain on 6/22/21.
//

import SwiftUI

struct BoardView: View {
    @StateObject var board: Board
    @State var currentPlayer: TileState
    @State var gameOver: Bool
    @State var tie: Bool
    
    let animationDuration = 1.5
    
    @State var applyAlpha: Bool = false
    
    var body: some View {
        if gameOver {
            gameOverView
        } else {
            game
        }
    }
    
    var gameOverView: some View {
        VStack {
            if tie == false {
                Text("\(currentPlayer.displayString) Won")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            } else {
                Text("Tie Game")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
            }

            Button(action: {
                currentPlayer = .playerX
                board.reset()
                gameOver = false
            }) {
                Text("New Game")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }.padding()
        }
    }
    
    var game: some View {
        VStack {
            HStack {
                Tile(tileState: $board.tiles[0], index: 0)
                    .onTapGesture { move(index: 0) }
                Tile(tileState: $board.tiles[1], index: 1)
                    .onTapGesture { move(index: 1) }
                Tile(tileState: $board.tiles[2], index: 2)
                    .onTapGesture { move(index: 2) }
            }
            HStack {
                Tile(tileState: $board.tiles[3], index: 3)
                    .onTapGesture { move(index: 3) }
                Tile(tileState: $board.tiles[4], index: 4)
                    .onTapGesture { move(index: 4) }
                Tile(tileState: $board.tiles[5], index: 5)
                    .onTapGesture { move(index: 5) }
            }
            HStack {
                Tile(tileState: $board.tiles[6], index: 6)
                    .onTapGesture { move(index: 6) }
                Tile(tileState: $board.tiles[7], index: 7)
                    .onTapGesture { move(index: 7) }
                Tile(tileState: $board.tiles[8], index: 8)
                    .onTapGesture { move(index: 8) }
            }
        }
    }
    
    func move(index:Int) {
        if board.canMove(index: index) {
            board.move(player: currentPlayer, index: index)
            if board.playerWon(player: currentPlayer) {
                gameOver = true
            } else {
                if board.noneEmpty() {
                    gameOver = true
                    tie = true
                }
                if currentPlayer == .playerX {
                    currentPlayer = .playerO
                    if MachineMove.heuristicMove(player: currentPlayer, board: board) {
                        if board.playerWon(player: currentPlayer) {
                            gameOver = true
                        } else {
                            if board.noneEmpty() {
                                gameOver = true
                                tie = true
                            } else {
                                currentPlayer = .playerX
                            }
                        }
                    }
                } else {
                    currentPlayer = .playerX
                }
            }
        }
    }
}

struct BoardView_Previews: PreviewProvider {
    @State static var emptyBoard = Board()
    static let twoTiles:[TileState] = [.playerX,.playerO,.empty,
                      .empty,.empty,.empty,
                      .empty,.empty,.empty]
    static let tieTiles:[TileState] = [.playerX,.playerO,.playerX,
                      .playerO,.playerX,.playerO,
                      .playerO,.playerX,.playerO]
    static let xWinTiles:[TileState] = [.playerX,.playerO,.playerX,
                      .playerO,.playerX,.playerO,
                                        .playerO,.empty,.playerX]
    @State static var tieBoard = Board.init(tiles: tieTiles)
    @State static var twoBoard = Board.init(tiles: twoTiles)
    @State static var xWinBoard = Board.init(tiles: twoTiles)
    
    @State static var playerX: TileState = .playerX
    
    @State static var gameOverTrue: Bool = true
    @State static var gameOverFalse: Bool = false
    
    @State static var tieTrue: Bool = true
    @State static var tieFalse: Bool = false
    
    static var previews: some View {
        Group {
            BoardView(board: emptyBoard, currentPlayer: playerX, gameOver: gameOverFalse, tie: tieFalse)
            BoardView(board: twoBoard, currentPlayer: playerX, gameOver: gameOverFalse, tie: tieFalse)
            BoardView(board: xWinBoard, currentPlayer: playerX, gameOver: gameOverTrue, tie: tieFalse)
            BoardView(board: tieBoard, currentPlayer: playerX, gameOver: gameOverTrue, tie: tieTrue)
        }
    }
}
