//
//  ContentView.swift
//  TicTacToe
//
//  Created by Hasan Edain on 6/22/21.
//

import SwiftUI

struct ContentView: View {
    @State var board = Board()
    var body: some View {
        BoardView(board: board, currentPlayer: .playerX, gameOver: false, tie: false)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
