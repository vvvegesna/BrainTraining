//
//  ContentView.swift
//  BrainTraining
//
//  Created by Vegesna, Vijay V EX1 on 2/10/20.
//  Copyright © 2020 Vegesna, Vijay V EX1. All rights reserved.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
        .frame(width: 150, height: 80)
        .background(Color.yellow)
        .font(.largeTitle)
        .clipShape(Capsule()).overlay(Capsule().stroke(Color.black, lineWidth: 2))
        .shadow(color: .black, radius: 2)
    }
}

extension View {
    func buttonStyle() -> some View {
        self.modifier(ButtonModifier())
    }
}

struct ContentView: View {
    
    var moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appChoice = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var myScore = 0
    @State private var questionsDone = false
    @State private var questionCount = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.red, .green]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20){
                VStack(spacing: 10) {
                    if questionsDone {
                        Text("Your Score: \(myScore)")
                            .padding()
                    } else {
                        Text("App's Move: \(moves[appChoice])")
                        if shouldWin {
                            Text("Win")
                        } else {
                            Text("Lose")
                        }
                    }
                }
                ForEach (0..<3) { number in
                    Button(action: {
                        self.playerTapped(number)
                        self.askQuestion()
                    }) {
                        Text(self.moves[number])
                            .buttonStyle()
                    }
                }
                Spacer()
            }
        }
    }
    
    func playerTapped(_ number: Int) {
        let a = number
        let b = appChoice
        let logic: Int
        guard !questionsDone else { return }
        
        logic = shouldWin ? (a - b + 3) : (b - a + 3)
        
        if (logic % 3 == 1) {
            myScore += 1
        } else {
            myScore -= 1
        }
    }
    
    func askQuestion() {
        questionCount += 1
        if questionCount >= 10 {
            questionsDone = true
            return
        }
        appChoice = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
