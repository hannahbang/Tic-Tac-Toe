//
//  GameView.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/15/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game:GameService //: bc creating an instance
    //environment property: ?
    //end game - forefeit/leave
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            if [game.player1.isCurrent, game.player2.isCurrent]
                //allSatisfy checks if parameter is true or false
                //$0 means -???
                .allSatisfy{$0 == false}
                {
                Text("Select a player to start")
                }
            HStack{
                Button(game.player1.name){
                    game.player1.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                
                Button(game.player2.name){
                    game.player2.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
                
            }//end of HStack
            
            .disabled(game.gameStarted)
            
            //create a gameboard
            VStack{
                HStack{
                    ForEach(0...2, id: \.self){
                        index in SquareView(index: index)
                    }
                }//end of first Hstack
                HStack{
                    ForEach(3...5, id: \.self){
                        index in SquareView(index: index)
                    }
                }//end of 2nd HStack
                HStack{
                    ForEach(6...8, id: \.self){
                        index in SquareView(index: index)
                    }
                }//end of 3rd HStack
                
            }//end of VStack
            .disabled(game.boardDisabled)
            
            VStack{
                //Result layout of the UI
                if game.gameOver{
                    Text("Game Over")
                    if game.possibleMoves.isEmpty{
                        Text("It's a draw!")
                    }//end of isEmpty check
                    else{
                        Text("\(game.currentPlayer.name) wins")
                    }//end of else
                    Button("New Game"){
                        game.reset()
                    }//end of Button
                    .buttonStyle(.borderedProminent)
                }//end of gameOver check
            }//end of Vstack
            .font(.largeTitle)
            
            Spacer()
            
                }//end VStack
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button("End Game"){
                    dismiss()
                }
                .buttonStyle(.bordered)
            }//end toolbar item
            
        }//end toolbar
        .navigationTitle("Cross Over")
        .onAppear{game.reset()}
        .inNavigationStack()
                        }//end View(var body)
                      }//end struct

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
        .environmentObject(GameService())
    }
}//end gameView struct

struct PlayerButtonStyle: ButtonStyle{
    let isCurrent:Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 8).fill(isCurrent ? Color.green:Color.gray))
            .foregroundColor(.white)
    }
}
