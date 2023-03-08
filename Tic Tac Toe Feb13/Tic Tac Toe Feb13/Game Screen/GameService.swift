//
//  GameService.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/20/23.
//

import SwiftUI

//has access to all UIs and gets all priorities; want to run it on the main thread
//operating system- diff apps going on at the same time
    //thread: creation of different instances
//main actor- put this on main thread
@MainActor

//class - group of similar stuff like structure
//ObservableObject- gives access to scope (like @state, @environment, etc.)
//@State- var can be changed by 2 or 3 views
//@Environment - across different views
//@Published- betw diff applications !!!STUDY THIS
class GameService: ObservableObject{
    @Published var player1 = Player(gamePiece: .x, name: "Player 1")
    @Published var player2 = Player(gamePiece: .o, name: "Player 2")
    @Published var possibleMoves = Moves.all
    @Published var movesTaken = [Int]()
    @Published var gameOver = false
    
    @Published var gameBoard = GameSquare.reset
    
    var gameType = GameType.single //fix this later
   
    //who the current player is for single mode
    var currentPlayer:Player{
        if player1.isCurrent{
            return player1
        }
        else{
            return player2
        }
    }//end of currentPlayer
    
    //track wether the game started or not
    var gameStarted: Bool{
        //don't base logic on buttons, do it on var instead
        //if either players are current, the game has started
        player1.isCurrent || player2.isCurrent //player 1 or 2 is current; don't say return cuz it already knows?; can also be done using if/else
    }
    
    //checks if the board is disabled or not
    var boardDisabled: Bool{
        gameOver  || !gameStarted //game is over or game hasn't started- no moves done?
        
    }
    
    //give the function game type, player1, player2
    func setupGame(gameType: GameType, player1Name: String, player2Name: String)
    {
        //gametype to a specific game type
        //whatever's being passed to player
        //click down- call the function from somewhere? send these back to enum
        //write a switch case
        switch gameType{
        case .single:
            self.gameType = .single
            player2.name = player2Name
        case .peer:
            //fix later
            self.gameType = .peer
        case .bot:
            //fix later
            self.gameType = .bot
        case .undetermined:
            //break here bc?
            break
        }
    }
    
    
    
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        //resets all moves
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Moves.all //the array that has all moves called all
        gameBoard = GameSquare.reset
}//end of func reset
    func updateMoves(index: Int){
        if player1.isCurrent{
            player1.moves.append(index+1)
            gameBoard[index].player = player1
        } else {
            player2.moves.append(index+1)
            gameBoard[index].player = player2
        }//end of else
    }//end of func updateMoves
    func checkIfWinner(){
        if player1.isWinner || player2.isWinner{
            gameOver = true
        }
    }//end of checkIfWinner
    func toggleCurrent(){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }//end of toggle
    
    func makeMove(at index:Int){
        if gameBoard[index].player == nil{
            withAnimation{
                updateMoves(index: index)
            }//end of withAnimation
        checkIfWinner()
            if !gameOver{
                if let matchingIndex = possibleMoves.firstIndex(where: {$0==(index+1)}){
                    possibleMoves.remove(at: matchingIndex)
                }//end of if statement
                toggleCurrent()
                
            }//end of gameOver
            
            if possibleMoves.isEmpty{
                gameOver=true
            }
            
        }
    }//end of makeMove

}//end of class


