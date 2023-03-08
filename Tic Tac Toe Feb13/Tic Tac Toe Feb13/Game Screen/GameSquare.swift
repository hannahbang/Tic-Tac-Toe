//
//  GameSquare.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/22/23.
//

import SwiftUI

//9 tiles, 3 rows and 3 columns, variable to track which tile it is
struct GameSquare{
    var id:Int //to track tiles 1 to 9
    var player:Player? //two types of players Swift doesn't know which one- have to include ? to specify
    var image:Image{
        if let player = player{
            return player.gamePiece.image
        }
        else{
            return Image("none")
        }
    }//end of image
    
    //stopped here 2/22; work on it over weekend with zoom recording
    static var reset: [GameSquare]{
    var squares = [GameSquare]()
        for index in 1...9{
            squares.append(GameSquare(id: index))
        }
        return squares
    }
    
}//end of struct
