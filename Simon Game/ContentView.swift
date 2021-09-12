//
//  ContentView.swift
//  Simon Game
//
//  Created by Student on 9/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var options = 0
    @State private var answers: [Int] = []
    @State private var count = -1
    @State private var greenHighlight: Bool = false
    @State private var yellowHighlight: Bool = false
    @State private var redHighlight: Bool = false
    @State private var blueHighlight: Bool = false
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading)
            {
                    Rectangle()
                        .fill(greenHighlight ? Color.black : Color.green)
                        .onTapGesture {
                            options = 1
                            count += 1
                            click()
                            greenHighlight = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                greenHighlight = false
                            })
                        }
                    Rectangle()
                        .fill(yellowHighlight ? Color.black : Color.yellow)
                        .onTapGesture {
                            options = 3
                            count += 1
                            click()
                            yellowHighlight = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                yellowHighlight = false
                            })
                        }
            }
            VStack(alignment: .leading) {
                    Rectangle()
                        .fill(redHighlight ? Color.black : Color.red)
                        .onTapGesture {
                            options = 2
                            count += 1
                            click()
                            redHighlight = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                redHighlight = false
                            })
                        }
                    Rectangle()
                        .fill(blueHighlight ? Color.black : Color.blue)
                        .onTapGesture {
                            options = 4
                            count += 1
                            click()
                            blueHighlight = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                blueHighlight = false
                            })
                        }
            }
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
        greenHighlight = true
        yellowHighlight = true
        redHighlight = true
        blueHighlight = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            greenHighlight = false
            yellowHighlight = false
            redHighlight = false
            blueHighlight = false
        })
        
    }
    
    func loop(times: Int) {
        var i = 0
        func nextIteration() {
            if i < times {
                if(answers[i] == 1)
                {
                    if(i > 0 && answers[i - 1] != 1){
                    greenHighlight = true
                    }
                    else{
                        greenHighlight = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        greenHighlight = true
                        })
                    }
                }
                if(answers[i] == 2)
                {
                    if(i > 0 && answers[i - 1] != 2){
                    redHighlight = true
                    }
                    else{
                        redHighlight = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        redHighlight = true
                        })
                    }
                }
                if(answers[i] == 3)
                {
                    if(i > 0 && answers[i - 1] != 3){
                    yellowHighlight = true
                    }
                    else{
                        yellowHighlight = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        yellowHighlight = true
                        })
                    }
                }
                if(answers[i] == 4)
                {
                    if(i > 0 && answers[i - 1] != 4){
                    blueHighlight = true
                    }
                    else{
                        blueHighlight = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                        blueHighlight = true
                        })
                    }
                }

                i += 1

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    greenHighlight = false
                    redHighlight = false
                    yellowHighlight = false
                    blueHighlight = false
                    nextIteration()
                }
            }
        }

        nextIteration()
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


