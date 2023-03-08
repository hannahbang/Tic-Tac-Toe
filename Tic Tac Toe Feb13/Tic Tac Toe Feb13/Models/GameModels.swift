//
//  GameModels.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/13/23.
//

import Foundation
import SwiftUI

//enumerated data type:
//creates different variables and numbering sequence, used for ordered set of numbers?
//use for anything with fixed types 
enum GameType {
case single, bot, peer, undetermined
    
    var description: String {
        switch self { //self: look at structure type and determine type of cases (similar to this.pointer)
            //. because referring to class or structure
        case .single:
            return "Share your device and play with a friend" //single player game-> see text
        case .bot:
            return "Play with your device"
        case .peer:
            return "Invite someone near you with the app and play"
        case .undetermined:
            return ""
        }
    }
}
//depending on the case, the image will be loaded
enum GamePiece: String{
    case x,o
    //then we went to assets, renamed images, and changed type to orignial image
    var image: Image{
        Image(self.rawValue) //gives error cuz Image is a part of SwiftUI; have to import SwiftUI at the top
    }
}
//keep track of player's name, moves, if it's current, who won
struct Player{
    let gamePiece:GamePiece //creating object of the GamePiece enum
    var name: String
    var moves: [Int] = [] //array to keep track of moves with integers
    var isCurrent = false
    var isWinner: Bool {
        //for loop to check win; goes through all winning moves
        for moves in Moves.winningMoves{
            //checks if all moves are done and the wining move is contained
            if moves.allSatisfy(self.moves.contains){
                return true
            }
        }
        return false //don't put it in first bracket cuz it'll only check first winning move

    }
    
}

enum Moves{
    static var all = [1,2,3,
                      4,5,6,
                      7,8,9]
    //multi dim array for winning moves
    //protect structure at basic level to eliminate chances of getting blown by hackers
    static var winningMoves = [
    [1,2,3],
    [4,5,6],
    [7,8,9],
    [1,4,7],
    [2,5,8],
    [3,6,9],
    [1,5,9],
    [3,5,7]
    
    ]
}

