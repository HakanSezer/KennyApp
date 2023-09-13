//
//  ViewController.swift
//  Kenny Game
//
//  Created by Hakan Sezer on 13.09.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    var score = 0
    var timer = Timer()
    var counter = 10
    var kennyArray = [UIImageView]()
    var hiTemir = Timer()
    var highScore = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: \(score)"
        
        // User Veri kayıt etme
        let storedHighScore = UserDefaults.standard.object(forKey: "HighScore")
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        
        // İmage Tıklanabilir yapmış olduk.
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        let gestureRec1 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec2 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec3 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec4 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec5 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec6 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec7 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec8 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        let gestureRec9 = UITapGestureRecognizer(target: self, action: #selector(changePic))
        
        kenny1.addGestureRecognizer(gestureRec1)
        kenny2.addGestureRecognizer(gestureRec2)
        kenny3.addGestureRecognizer(gestureRec3)
        kenny4.addGestureRecognizer(gestureRec4)
        kenny5.addGestureRecognizer(gestureRec5)
        kenny6.addGestureRecognizer(gestureRec6)
        kenny7.addGestureRecognizer(gestureRec7)
        kenny8.addGestureRecognizer(gestureRec8)
        kenny9.addGestureRecognizer(gestureRec9)
        
        kennyArray = [kenny1,kenny2,kenny3,kenny4,kenny5,kenny6,kenny7,kenny8,kenny9]
        
        
        hideKenny()
        
        //Timer
        timeLabel.text = ""
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunctions), userInfo: nil, repeats: true)
        hiTemir = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
    }
    
    // Func
    func alertFunc(title: String, massage: String) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
            // Replay Func
            self.score = 0
            self.scoreLabel.text = "\(self.score)"
            self.counter = 10
            self.timeLabel.text = String(self.counter)
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerFunctions), userInfo: nil, repeats: true)
            self.hiTemir = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            
            
        }
        
        alert.addAction(okButton)
        alert.addAction(replayButton)
        self.present(alert, animated: true)
    }
    
    @objc func hideKenny() {
        
        for ken in kennyArray {
            ken.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[random].isHidden = false
    }
    
    // Resimin üstüne tıklmayı sağlıyor.
    @objc func changePic() {
        score += 1
        scoreLabel.text = "Score \(score)"
    }
    // Timer fonksiyonu.
    @objc func timerFunctions() {
        timeLabel.text = "Time: \(counter)"
        counter -= 1
        if counter == 0 {
            timer.invalidate()
            hiTemir.invalidate()
            alertFunc(title: "Oyun Bitti", massage: "Oyun Bitti. Score: \(score)")
        }
        
        
        if self.score > self.highScore {
            self.highScore = self.score
            highScoreLabel.text = "HighScore: \(self.highScore)"
            UserDefaults.standard.set(highScoreLabel.text!, forKey: "HighScore")
        }
    }
}
