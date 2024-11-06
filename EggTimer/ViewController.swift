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
    
    let eggTimes = ["Soft": 3, "Medium": 420, "Hard": 720]
        
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer?

    var timer = Timer()
    
    @IBAction func hardenessSeletected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timer.invalidate()
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0
        
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                let progress = Float(self.secondsPassed )/Float(self.totalTime)
                self.progressBar.progress = progress
            } else {
                Timer.invalidate()
                self.titleLabel.text = "Done"
                self.progressBar.progress = 1.0
                let url  = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                self.player = try! AVAudioPlayer(contentsOf: url!)
                self.player?.play()
               
            }
        }
        
    }
    
}
