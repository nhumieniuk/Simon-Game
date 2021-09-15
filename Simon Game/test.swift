//
//  test.swift
//  Simon Game
//
//  Created by Student on 9/14/21.
//

import Foundation
import AVFoundation

playAudio(name: "silent")

func playAudio(name: String)
{
    if let audioURL = Bundle.main.url(forResource: name, withExtension: "wav") {
            do {
                try self.audioPlayer = AVAudioPlayer(contentsOf: audioURL)
                self.audioPlayer?.play()
                } catch {
                    print("Couldn't play audio. Error: \(error)")
                }
        
    }
}
