//
//  ContentView.swift
//  BeALoser
//
//  Created by Ali Khorramipour on 1/5/23.
//


import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameLength = 0
    @State private var gameOver = false
    @State private var questionsAnswered = 0
    // 0: rock, 1: paper, 2: scissors
    var answers = ["Rock", "Paper", "Scissors"]
    let answerEmojis = ["🪨", "📄", "✂️"]
    @State private var computerPicked = 0
    @State private var loserOrWinner = Bool.random()
    @State private var answer = ""
    @State private var correctAnswer = ""
    
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.green, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack{
                Spacer()
                Text("AI picked \(answers[computerPicked]) \(answerEmojis[computerPicked])")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                
                VStack(spacing: 15){
                    VStack{
                        if loserOrWinner{
                            Text("Which one Wins?")
                                .foregroundStyle(.secondary)
                                .font(.largeTitle)
                        } else{
                            Text("Which one Loses?")
                            .foregroundStyle(.secondary)
                            .font(.largeTitle)
                        }
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            answerTapped(number)
                        } label:{
                            Text("\(answers[number]) \(answerEmojis[number])")
                                .foregroundStyle(.primary)
                                .font(.largeTitle.bold())
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 33))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Answered: \(questionsAnswered)/5")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding()
            // alert after game is over
            .alert(scoreTitle, isPresented: $gameOver){
                Button("Restart", action: start)
            } message: {
                Text("Game Over!\nYour final score is \(score)/5")
            }
            // alert after each answer
            .alert(scoreTitle, isPresented: $showingScore){
                Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }
        }
    }
    
    func answerTapped(_ number: Int){
        if answers[number] == correctAnswer{
            scoreTitle = "Correct!"
            score += 1
            questionsAnswered += 1
        } else {
            scoreTitle = "Incorrect!"
            score -= 1
            questionsAnswered += 1
        }
        showingScore = true
        
        if questionsAnswered == 5 {
            gameOver = true
            showingScore = false
        }
    }
    
    func askQuestion(){
        loserOrWinner = Bool.random()
        computerPicked = Int.random(in: 0...2)
        // if the player should win
        if loserOrWinner{
            switch computerPicked{
            case 0: correctAnswer = "Paper"
            case 1: correctAnswer =  "Scissors"
            case 2: correctAnswer = "Rock"
            default: correctAnswer = "bruh"
            }
        } else{
            switch computerPicked{
            case 0: correctAnswer = "Scissors"
            case 1: correctAnswer = "Rock"
            case 2: correctAnswer = "Paper"
            default: correctAnswer = "bruh"
            }
        }
    }
    
    func start(){
        loserOrWinner = Bool.random()
        computerPicked = Int.random(in: 0...2)
        if loserOrWinner{
            switch computerPicked{
            case 0: correctAnswer = "Paper"
            case 1: correctAnswer =  "Scissors"
            case 2: correctAnswer = "Rock"
            default: correctAnswer = "bruh"
            }
        } else{
            switch computerPicked{
            case 0: correctAnswer = "Scissors"
            case 1: correctAnswer = "Rock"
            case 2: correctAnswer = "Paper"
            default: correctAnswer = "bruh"
            }
        }
        score = 0
        questionsAnswered = 0
        gameOver = false
        showingScore = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
