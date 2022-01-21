//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()
    var player: AVAudioPlayer?
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 0.0
        let hardness: String? = sender.currentTitle
        let minutes = eggTimes[hardness!]!
        let totalTime = minutes // * 60
        var secondsPass = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondsPass < totalTime {
                
                secondsPass += 1
                progressBar.progress = Float(secondsPass) / Float(totalTime)
                
            } else {
                Timer.invalidate()
                titleLabel.text = "DONE"
                

                func playSound() {
                    guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }

                    do {
                        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                        try AVAudioSession.sharedInstance().setActive(true)

                        /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                        /* iOS 10 and earlier require the following line:
                        player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                        guard let player = player else { return }

                        player.play()

                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            }
            
        }
    }
    
}
