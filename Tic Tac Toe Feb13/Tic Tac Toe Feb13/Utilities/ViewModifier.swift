//
//  ViewModifier.swift
//  Tic Tac Toe Feb13
//
//  Created by Hannah Bang on 2/15/23.
//

import SwiftUI

//NavStackContainer-?
struct NavStackContainer: ViewModifier{
    //know which version iOS and shows that UI
    func body(content: Content) -> some View {
        //if iOS 16 version, wrap around navigation stack to whatever modifier is connected to; otherwise wrap it with navigation view
        if #available(iOS 16, *){
            NavigationStack{
                content
                            }//NavigationStack
            
                                 }//if available iOS
            else{
                NavigationView{
                    content
                               }//content for navigation view
                .navigationViewStyle(.stack)
                    
                }//else statement
                                              }//func body
                                      }//end struct viewModifier

//whichever view calls for modifier property, return this property
extension View{
    public func inNavigationStack () -> some View{
        return self.modifier(NavStackContainer())
                                                  }//end some View
               }//end extension

