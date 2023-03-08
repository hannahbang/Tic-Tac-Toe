//
//  ContentView.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/13/23.
//

import SwiftUI

struct StartView: View {
    //state properties: @State
    //tracks the variable within the scope of the variable- remembers it when it changes
    //game type, what is your name, opponent's name
    
    //private variable: private within the scope of structure and class, cannot be used outside the class
    //variable called gameType- an object to the class/structure
    //default value: .undetermined
    //@published- automatically update UI without changing it???
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    //where do you want focus to be on: keyboard or not keyboard
    @FocusState private var focus: Bool
    @State private var startGame = false //game hasn't started???
    //added a new property 2/22
    @EnvironmentObject var game:GameService //swift runs background threads behind the scenes
    
    
    
    
    var body: some View {
        //Navigation view only available iOS 16
        
    
        
        VStack {
            Picker("Select Game", selection: $gameType)  {
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two Sharing Device").tag(GameType.single)
                Text("Challenge your Device").tag(GameType.bot)
                Text("Challenge a Friend").tag(GameType.peer)
            }
            //creates rounded rectangle border: shows description by finding it from enum game type
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(style: StrokeStyle(lineWidth: 2)).accentColor(.primary))
            
            Text(gameType.description)
                .padding()
            
            //switch statement on game types: text fields for each case (name, opponent's name); entry is blank; switch case
            
            //when click on option, shows you where you enter name
            VStack{
                switch gameType{
                case .single:
                    TextField("Your Name", text: $yourName
                    )//stores the input into yourname variable above
                    TextField("Opponent Name", text: $opponentName
                    )
                case .bot:
                    TextField("Your Name", text: $yourName
                    )
                case .peer:
                    EmptyView() //we will fix this later
                case .undetermined:
                    EmptyView()
                                }//end for switch
                }//end for VStack
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus) //for keyboard or not keyboard... putting in names vs playing game
            .frame(width: 350)
            
            //Don't allow press start if name is not typed out
            //when you click on start game button
            //what is random?
            //runs probability based numbers on a set of numbers; multiple distributions so it's difficult for us to figure out fast(why duo authentication expires after a few mins)
            if gameType != .peer{
                Button("Start Game"){
                    game.setupGame(gameType: gameType, player1Name: yourName, player2Name: opponentName)
                    focus = false //don't want keyboard to appear yet
                    startGame.toggle() //startGame is a structure
                }
                .buttonStyle(.borderedProminent)
                //when the button is disabled
                .disabled(
                    gameType == .undetermined || //or
                    gameType == .bot &&  (yourName.isEmpty) || //and
                    //not and bc both names typed will lead to disabled button
                    gameType == .single && (yourName.isEmpty || opponentName.isEmpty)
                    
                         )
                Image("LightModeWelcome")
            }
            Spacer()
            
            
        }
        .padding()
        .fullScreenCover(isPresented: $startGame){
            GameView()
        }
        .navigationTitle("Cross Over")
        .inNavigationStack()
    }//end of body
}//end of struct

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
        //added modifier
            .environmentObject(GameService()) //telling the preview what's going on
    }
}
