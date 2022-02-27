//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Soo Hwan Kim on 2022/02/20.
//

import SwiftUI

// TODO: Refactor showAlert state var name so we can have two different alerts
// TODO: Use emojis instead of text for rock scissors paper
// TODO: Add ZStack and add color to make app prettier

struct ContentView: View {
    let arrayOfChoices = ["Rock", "Scissors", "Paper"]
    let arrayOfChoicesCounter = ["Paper", "Rock", "Scissors"]

    @State private var currentChoice: String = ""
    @State private var currentCounter: String = ""
    @State private var shouldPlayerWin = false
    @State private var showAlert = true
    @State private var showGameOverAlert = false
    @State private var score = 0
    @State private var round = 1
    @State private var isPlayerAnswerCorrect = false
    
    func setShouldPlayerWin(_ value: Bool) {
        let randomIndex = Int.random(in: 0..<arrayOfChoices.count)

        currentChoice = arrayOfChoices[randomIndex]
        currentCounter = arrayOfChoicesCounter[randomIndex]
        shouldPlayerWin = value
    }
    
    func checkAnswer(_ answer: String) {
        print(round)
            if(answer == currentCounter && shouldPlayerWin) {
                score += 1
                isPlayerAnswerCorrect = true
            } else if (answer != currentCounter && !shouldPlayerWin) {
                score += 1
                isPlayerAnswerCorrect = true
            } else {
                if(score > 0) {
                    score -= 1
                }
                isPlayerAnswerCorrect = false

            }
        
        if(round < 10) {
            round += 1
            showAlert = true
            return
        }
        
        showGameOverAlert = true
    }
    
    func resetGame() {
        round = 1
        score = 0
        currentChoice = ""
        currentCounter = ""
        showAlert = true
    }
    
    
    var body: some View {
        Spacer()
        
        VStack {
            Text("Score: \(score)")
            
            Text(currentChoice)
                .padding()
                .alert("\(round > 1 ? (isPlayerAnswerCorrect ? "Correct Answer!" : "Wrong Answer :(") : "") Do you want to win or lose this round?", isPresented: $showAlert) {
                    Button("Lose") {
                        setShouldPlayerWin(false)
                    }
                    
                    Button("Win") {
                        setShouldPlayerWin(true)
                    }
                }
            
            if(!currentChoice.isEmpty) {
                Text("Player Choice: \(shouldPlayerWin ? "Win" : "Lose")")
            }
            
        }
        
        Spacer()
        
        HStack {
            ForEach(arrayOfChoices.indices) { index in
                Button(action: {checkAnswer(arrayOfChoices[index])}) {
                    Text("\(arrayOfChoices[index])")
                }
                .padding()
                .background(.gray)
            }
        }
        .alert("Game Over!", isPresented: $showGameOverAlert) {
            Button("Ok") {
                resetGame()
            }
        } message: {
            Text("Your total score is \(score)")
        }
        
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
