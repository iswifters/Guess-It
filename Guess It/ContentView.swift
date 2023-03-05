//
//  ContentView.swift
//  Guess It
//
//  Created by MAC on 05/03/2023.
//
import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    @State private var givenNumber = Int.random(in: 0...2)
    @State private var selectedFlag = ""
    @State private var givenFlag = ""
    @State private var points =  0
    @State private var scoreTitle = ""
    @State private var finalTitle = ""
    @State private var finalMessage = ""
    @State private var totalScore =  0
    @State private var showingScore = false
    @State private var isRotating = false
    @State private var showingGameEnd = false
    @State private var trial = 0
    @State private var rotateAmount = 0.0
    @State private var scaleAmount = 1.0
    @State private var opacityAmount = 1.0
    
    
    var body: some View {
        ZStack {
 //---------------------------------
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    //-----------------------------
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[givenNumber])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    //----------------------------
                    ForEach(0..<3) { number in
                        FlagImageView(number: number, image: countries[number], method: flagTapped)
                            .rotation3DEffect(givenNumber == number ? .degrees(Double(rotateAmount)) :.degrees(0.0), axis: (x: 0, y: 1, z: 0))
                            .opacity(countries[number] != givenFlag  ? opacityAmount : 1.0)
                            .scaleEffect(countries[number] != givenFlag ?  scaleAmount : 1)
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                //---------------------------------
                
                Spacer()
                if showingGameEnd {
                    Text("Total Score: \(totalScore)")
                        .foregroundColor(.white)
                        .font(.title.bold())
                        .transition(.scale)
                }
                Spacer()
            }.padding()
            
            
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("That's the Flag of \(selectedFlag). \n You've earned \(points) points!")
        }
        
        .alert(finalTitle, isPresented: $showingGameEnd) {
            Button("Reset Game") {resetGame()}
        } message: {
            Text("\(finalMessage) \n Your final score is \(totalScore).")
        }
        
    }
    
    
    //------------------------------
    func flagTapped(_ number: Int) {
        if number == givenNumber {
            
            withAnimation(.interpolatingSpring(stiffness: 5, damping: 10)){
                rotateAmount += 360
            }
            
            scoreTitle = "Correct"
            points = 3
            
        } else {
            scoreTitle = "Wrong"
            points = 0
        }
        
        selectedFlag = countries[number]
        givenFlag = countries[givenNumber]
        totalScore += points
        showingScore = true
        
        
        withAnimation(.easeOut){
            scaleAmount = 0.8
            opacityAmount = 0.25
        }
    }
    
    
    //------------------------------
    func askQuestion() {
        trial += 1
        
        if (trial < 8) {
            countries.shuffle()
            givenNumber = Int.random(in: 0...2)
            scaleAmount = 1.0
            opacityAmount = 1
            rotateAmount = 0.0
            
        }
        else{
            withAnimation(.spring()) {
                showingGameEnd = true
            }
            endGame()
        }
        
    }
    
    //------------------------------
    func endGame() {
        switch totalScore {
        case 0...9:
            finalTitle = "Ohh No!!!"
            finalMessage = "That was a poor attempt!"

        case 12...15:
            finalTitle = "Okayy!!"
            finalMessage = "Not Bad at All!"

        case 18...21:
            finalTitle = "Congratulations!!!"
            finalMessage = "That was Amazing!"

        default:
            finalTitle = "Congratulations!!!"
            finalMessage = "You're a Freaking Genius!"
            

        }
    }
    
    //------------------------------
    func resetGame() {
        selectedFlag = ""
        points =  0
        scoreTitle = ""
        finalTitle = ""
        finalMessage = ""
        totalScore =  0
        showingScore = false
        showingGameEnd = false
        trial = 0
        countries.shuffle()
        givenNumber = Int.random(in: 0...2)
        scaleAmount = 1.0
        opacityAmount = 1.0
        rotateAmount = 0.0
   }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
