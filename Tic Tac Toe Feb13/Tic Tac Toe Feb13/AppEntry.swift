//
//  Tic_Tac_Toe_Feb13App.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/13/23.
//

import SwiftUI

//entry(first) point to ContentView; where you enter the app
@main
struct AppEntry: App {
    @StateObject var game = GameService() //generate an instance ()
    //class vs struct - ??
    //instances are independent in structures (value type)
    //class instances are duplicates (reference type)
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game) //pass in the game object cuz we just made it
            
        }
    }
}
