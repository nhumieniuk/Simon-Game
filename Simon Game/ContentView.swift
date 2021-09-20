//
//  ContentView.swift
//  Simon Game
//
//  Created by Student on 9/9/21.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var options = 0
    @State private var answers: [Int] = []
    @State private var count = -1
    @State private var highScore = 0
    @State private var highlight = [false, false, false, false, false]
    @State private var startButton = true
    @State var audioPlayer: AVAudioPlayer?
    var body: some View {
        ZStack(alignment: .center)
        {
        HStack(alignment: .top) {
            VStack(alignment: .leading)
            {
                    Rectangle()
                        .fill(Color.green)
                        .opacity(highlight[0] ? 1 : 0.4)
                        .onTapGesture {
                            click(square: 1)
                        }
                    Rectangle()
                        .fill(Color.yellow)
                        .opacity(highlight[2] ? 1 : 0.4)
                        .onTapGesture {
                            click(square: 3)
                        }
            }
            VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.red)
                        .opacity(highlight[1] ? 1 : 0.4)
                        .onTapGesture {
                            click(square: 2)
                        }
                    Rectangle()
                        .fill(Color.blue)
                        .opacity(highlight[3] ? 1 : 0.4)
                        .onTapGesture {
                            click(square: 4)
                        }
            }
        }
            Text("Simon \n Highscore: \(highScore)")
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 250, height: 250)
                .background(Circle().fill(Color.black))
                .font(Font.custom("impact", size: 40))
                .onAppear {
                    playAudio(name: "silent") //this initializes the audioplayer and plays a silent wav, so the first click no longer lags the game
                }
                .onTapGesture {
                    if(startButton == true)
                    {
                        startButton = false
                        click(square: 0)
                        playAudio(name: "Start")
                    }
                }
                
            .preferredColorScheme(.dark)
        }
        
    }
    func click(square: Int)
    {
        if(startButton == false || answers.count > 0) { // if the game has not been started yet don't do anything
            count += 1
            if(square > 0){ //if it is a square
                options = square
                playAudio(name: "\(square - 1)")
                highlight[square - 1] = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15, execute: {
                    if(options != 0){ //the square will not unhighlight if loseAndClear() has been run (as the game has been lost and the animation of losing has to play out)
                        highlight[square - 1] = false
                    }
                })
            }
        if(count == 0) //if the start button is pushed add a random answer
        {
            answers.append(Int.random(in: 1..<5))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //add a short delay so the start sound can play
                loop(times:answers.count)
                }
        }
        else{
            if(count == answers.count) //if youve clicked to the end of the array
            {
                if(options == answers[count - 1]){ // if you got the last answer correct
                    answers.append(Int.random(in: 1..<5)) //add another random answer
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        loop(times:answers.count) //show squares
                        }
                    if count > highScore //if your score is higher than your highscore set it as your highscore
                    {
                        highScore = count
                    }
                    count = 0 //reset the times youve hit the squares
                }
                else //if you get the last square wrong you lose
                {
                    loseAndClear()
                }
            }
            else //if youre still answering do nothing unless you get it wrong
            {
                if(options != answers[count - 1])
                {
                    loseAndClear()
                }
            }
        }
    }
    }
    func loseAndClear() //reset everything and do everything associated with losing
    {
        count = -1
        options = 0
        answers.removeAll()
        startButton = true
        playAudio(name: "Lose")
        (highlight[0], highlight[2], highlight[1], highlight[3]) = (true, true, true, true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            (highlight[0], highlight[2], highlight[1], highlight[3]) = (false, false, false, false)
        })
        
    }
    
    func loop(times: Int) { // a recursive loop that goes through answers and highlights each button so far (idea from https://stackoverflow.com/a/49370694)
        var i = 0
        func nextIteration() {
            if i < times {
                let highlightNumber = answers[i] - 1
                    if(i > 0 && answers[i - 1] != answers[i]){ //if the last square is not the same as the last square, then highlight the current square and play the audio associated with it
                        highlight[(answers[i]) - 1] = true
                        playAudio(name: "\(highlightNumber)")
                    }
                    else{ //if the last square IS the same, unselect the square for 50ms and rehighlight it
                        highlight[(answers[i]) - 1] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                           highlight[highlightNumber] = true //game crashes if highlight[(answers[i]) - 1] is used?????????? what
                            playAudio(name: "\(highlightNumber)")
                        })
                    }
                i += 1

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { //after 500 ms unselect the square being shown
                    (highlight[0], highlight[1], highlight[2], highlight[3]) = (false, false, false, false)
                    nextIteration()
                }
            }
        }

        nextIteration()
    }
    func playAudio(name: String) //put name of file in parameters and it will play it (must be wav for this specific function)
    {
        if let audioURL = Bundle.main.url(forResource: name, withExtension: "wav") {
                do {
                    try self.audioPlayer = AVAudioPlayer(contentsOf: audioURL)
                    self.audioPlayer?.prepareToPlay()
                    self.audioPlayer?.play()
                    } catch {
                        print("Couldn't play audio. Error: \(error)")
                    }
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


