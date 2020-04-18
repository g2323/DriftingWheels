//
//  ContentView.swift
//  DriftingWheels
//
//  Created by Dr. Nürnberg on 09.04.20.
//  Copyright © 2020 G2323. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @ObservedObject var manager = HttpPostCommand()
    
    var body: some View {
        VStack {
            MapView()
            HStack {
                Button(action: {
                    
                }) {
                    Text("+")
                }
                Button(action: {
                    
                }) {
                    Text("-")
                }
                Button(action: {
                    
                }) {
                    Text("Clear")
                }
                Button(action: {
                    
                }) {
                    Text("Fix")
                }
            }
            HStack {
                Button(action: {
                    self.manager.postCommand(action: "START")
                }) {
                    Text("Start")
                        .background(self.manager.currentAction == "START" ?  Color.secondary : Color.clear)
                }
                Button(action: {
                    self.manager.postCommand(action: "STOP")
                }) {
                    Text("Stop")
                        .background(self.manager.currentAction == "STOP" ?  Color.secondary : Color.clear)
                }
                Button(action: {
                    self.manager.postCommand(action: "REPLAY")
                }) {
                    Text("Replay")
                        .background(self.manager.currentAction == "REPLAY" ?  Color.secondary : Color.clear)
                }
                Button(action: {
                    self.manager.postCommand(action: "SHUTDOWN")
                }) {
                    Text("Shutdown")
                        .background(self.manager.currentAction == "SHUTDOWN" ?  Color.secondary : Color.clear)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



