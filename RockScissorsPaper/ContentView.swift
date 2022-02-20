//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Soo Hwan Kim on 2022/02/20.
//

import SwiftUI

let arrayOfChoices = ["Rock", "Scissors", "Paper"]

struct ContentView: View {
    @State private var currentChoice = arrayOfChoices.randomElement()
    @State private var showStartButton = true
    @State private var shouldPlayerWin = false
    @State private var showAlert = false
    @State private var userAnswer = ""
    
    func setShouldPlayerWin(_ value: Bool) {
        shouldPlayerWin = value
    }
    
    func setUserAnswer(_ value: String) {
        userAnswer = value
    }
    
    var body: some View {
        if(showStartButton) {
            Button("Start Game") {
                showAlert = true
                showStartButton = false
            }
        } else {
            Text(currentChoice ?? "")
                .padding()
                .alert("Win or Lose?", isPresented: $showAlert) {
                    Button("Win") {
                        setShouldPlayerWin(true)
        
                    }
                    Button("Lose", role: .destructive) {
                        setShouldPlayerWin(false)
                    }
                }
            
            HStack {
                ForEach(arrayOfChoices.indices) { index in
                    Button(action: {setUserAnswer(arrayOfChoices[index])}) {
                        Text("\(arrayOfChoices[index])")
                    }
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
