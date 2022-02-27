//
//  ContentView.swift
//  RockScissorsPaper
//
//  Created by Soo Hwan Kim on 2022/02/20.
//

import SwiftUI

struct ContentView: View {
    let arrayOfChoices = ["Rock", "Scissors", "Paper"]
    let arrayOfChoicesCounter = ["Paper", "Rock", "Scissors"]
    let choicesWithEmojiValueDictionary = ["Rock": "🪨", "Scissors": "✂️", "Paper": "🧻"]

    @State private var currentChoice: String = ""
    @State private var currentCounter: String = ""
    @State private var shouldPlayerWin = false
    @State private var showPromptAlert = true
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
            showPromptAlert = true
            return
        }
        
        showGameOverAlert = true
    }
    
    func resetGame() {
        round = 1
        score = 0
        currentChoice = ""
        currentCounter = ""
        showPromptAlert = true
    }
    
    
    var body: some View {
        Spacer()
        
        VStack(spacing: 50) {
            Text("Score: \(score)")
                .font(.largeTitle.bold())
            
            Text(choicesWithEmojiValueDictionary[currentChoice] ?? currentChoice)
                .padding()
                .alert("\(round > 1 ? (isPlayerAnswerCorrect ? "Correct Answer!" : "Wrong Answer :(") : "") Do you want to win or lose this round?", isPresented: $showPromptAlert) {
                    Button("Lose") {
                        setShouldPlayerWin(false)
                    }
                    
                    Button("Win") {
                        setShouldPlayerWin(true)
                    }
                }
                .font(.system(size: 200))
            
            if(!currentChoice.isEmpty) {
                Text("Please choose the option that will \(shouldPlayerWin ? "win" : "lose") this round")
            }
            
        }
        
        Spacer()
        
        HStack(spacing: 30) {
            ForEach(arrayOfChoices.indices) { index in
                Button(action: {checkAnswer(arrayOfChoices[index])}) {
                    Text(choicesWithEmojiValueDictionary[arrayOfChoices[index]]!)
                }
                .padding()
                .font(.system(size: 50))
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
