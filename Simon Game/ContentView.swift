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
    @State private var highlight = [false, false, false, false]
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
                            options = 1
                            count += 1
                            click()
                            highlight[0] = true
                            playAudio(name: "1")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                highlight[0] = false
                            })
                        }
                    Rectangle()
                        .fill(Color.yellow)
                        .opacity(highlight[2] ? 1 : 0.4)
                        .onTapGesture {
                            options = 3
                            count += 1
                            click()
                            highlight[2] = true
                            playAudio(name: "3")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                highlight[2] = false
                            })
                        }
            }
            VStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.red)
                        .opacity(highlight[1] ? 1 : 0.4)
                        .onTapGesture {
                            options = 2
                            count += 1
                            click()
                            highlight[1] = true
                            playAudio(name: "2")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                highlight[1] = false
                            })
                        }
                    Rectangle()
                        .fill(Color.blue)
                        .opacity(highlight[3] ? 1 : 0.4)
                        .onTapGesture {
                            options = 4
                            count += 1
                            click()
                            highlight[3] = true
                            playAudio(name: "4")
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                highlight[3] = false
                            })
                        }
            }
        }
            Text("Simon")
                .multilineTextAlignment(.center)
                .padding()
                .frame(width: 250, height: 250)
                .background(Circle().fill(Color.black))
                .font(Font.custom("impact", size: 72))
                
            .preferredColorScheme(.dark)
        }
        
    }
    func click()
    {
        print("The count is \(count), ")
        print("you clicked option \(options)")
        if(count == 0)
        {
            options = 0
            answers.append(Int.random(in: 1..<5))
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                loop(times:answers.count)
                }
        }
        else{
            if(count == answers.count)
            {
                if(options == answers[count - 1]){
                    answers.append(Int.random(in: 1..<5))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        loop(times:answers.count)
                        }
                    count = 0
                }
                else
                {
                    print("you lost" + " option: \(options) answer: \(answers[count - 1])")
                    clear()
                }
            }
            else
            {
                if(options != answers[count - 1])
                {
                    print("you lose" + " option: \(options) answer: \(answers[count - 1])")
                    clear()
                }
            }
        }
    }
    func clear()
    {
        count = -1
        options = 0
        answers.removeAll()
        playAudio(name: "Lose")
        (highlight[0], highlight[2], highlight[1], highlight[3]) = (true, true, true, true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            (highlight[0], highlight[2], highlight[1], highlight[3]) = (false, false, false, false)
        })
        
    }
    
    func loop(times: Int) {
        var i = 0
        func nextIteration() {
            if i < times {
                if(answers[i] == 1)
                {
                    if(i > 0 && answers[i - 1] != 1){
                    highlight[0] = true
                        playAudio(name: "1")
                    }
                    else{
                        highlight[0] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                        highlight[0] = true
                            playAudio(name: "1")
                        })
                    }
                }
                if(answers[i] == 2)
                {
                    if(i > 0 && answers[i - 1] != 2){
                    highlight[1] = true
                        playAudio(name: "2")
                    }
                    else{
                        highlight[1] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                        highlight[1] = true
                            playAudio(name: "2")
                        })
                    }
                }
                if(answers[i] == 3)
                {
                    if(i > 0 && answers[i - 1] != 3){
                    highlight[2] = true
                        playAudio(name: "3")
                    }
                    else{
                        highlight[2] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                        highlight[2] = true
                            playAudio(name: "3")
                        })
                    }
                }
                if(answers[i] == 4)
                {
                    if(i > 0 && answers[i - 1] != 4){
                    highlight[3] = true
                        playAudio(name: "4")
                    }
                    else{
                        highlight[3] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
                        highlight[3] = true
                            playAudio(name: "4")
                        })
                    }
                }

                i += 1

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    highlight[0] = false
                    highlight[1] = false
                    highlight[2] = false
                    highlight[3] = false
                    nextIteration()
                }
            }
        }

        nextIteration()
    }
    func playAudio(name: String)
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


