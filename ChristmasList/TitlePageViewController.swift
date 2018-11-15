//
//  ViewController.swift
//  customCell
//
//  Created by Jack Worthley on 11/14/18.
//  Copyright © 2018 Jack Worthley. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var gifthing: UIImageView!
    var player: AVAudioPlayer = AVAudioPlayer()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            gifthing.loadGif(name: "snowGlobe")
        do {
            let audioPath = Bundle.main.path(forResource: "santa", ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
        
        } catch {
            print(error)
        }
        player.play()
        
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print(error)
        }
        
       
    }
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "logIn", sender: sender)
    }
    

  

}
