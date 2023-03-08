//
//  SquareView.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 3/1/23.
//

import SwiftUI

struct SquareView: View {
    @EnvironmentObject var game: GameService
    //to access the GameService class in this view
    let index: Int
    var body: some View {
        Button{
            game.makeMove(at: index)
        }
    label: {
        game.gameBoard[index].image
            .resizable()
            .frame(width:100, height: 100)
            .border(.primary)
            }
    .disabled(game.gameBoard[index].player != nil)
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 1)
            .environmentObject(GameService())
    }
}
