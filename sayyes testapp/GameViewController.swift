//
//  GameViewController.swift
//  sayyes testapp
//
//  Created by Alex Rudoi on 27/4/21.
//

import UIKit
import SnapKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var blockView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    var tap = UILongPressGestureRecognizer()
    
    var score = 0
    var best = 0
    var isWon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tap = UILongPressGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tap.minimumPressDuration = 0.05
        tap.delaysTouchesBegan = true
        view.addGestureRecognizer(tap)
        
        getUD()
        newLevel()
    }
    
    private func getUD() {
        score = userDefaults.integer(forKey: "score")
        best = userDefaults.integer(forKey: "best")
        
        scoreLabel.text = "\(score)"
        bestLabel.text = "BEST: \(best)"
    }
    
    private func setUD() {
        userDefaults.set(score, forKey: "score")
        userDefaults.set(best, forKey: "best")
        
        scoreLabel.text = "\(score)"
        bestLabel.text = "BEST: \(best)"
    }
    
    @objc func handleTap(_ sender: UILongPressGestureRecognizer) {
        if sender.state != .ended {
            for cons in self.blockView.constraints {
                if cons.identifier == "widthCons" {
                    if cons.constant <= (self.view.frame.width * 0.8) {
                        cons.constant += 5
                    } else {
                        cons.constant = 80
                    }
                }
            }
        } else {
            print(blockView.frame.width,"to",stackView.spacing)
            
            var stopY = stackView.frame.minY - blockView.frame.height
            
            if blockView.frame.width <= stackView.spacing {
                stopY = view.frame.height
                isWon = true
            } else {
                isWon = false
            }
            
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseIn) { [self] in
                tap.isEnabled = false
                blockView.frame = CGRect(x: blockView.frame.minX, y: stopY, width: blockView.frame.width, height: blockView.frame.height)
            } completion: { _ in
                self.tap.isEnabled = true
                self.bgAnimation()
                self.checkWinner()
            }
            
        }
    }
    
    private func newLevel() {
        let random = CGFloat.random(in: 85..<(view.frame.width*0.6))
        stackView.spacing = random
        for cons in self.blockView.constraints {
            if cons.identifier == "widthCons" {
                cons.constant = 80
            }
        }
    }
    
    private func checkWinner() {
        if isWon {
            print("you won")
            score += 1
            newLevel()
        } else {
            print("you loose")
            if score > best {
                best = score
                bestLabel.text = "BEST: \(best)"
            }
            goToResults()
            score = 0
        }
        setUD()
        scoreLabel.text = "\(score)"
    }
    
    private func goToResults() {
        let resultVC = storyboard!.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        resultVC.best = self.best
        resultVC.result = self.score
        resultVC.modalPresentationStyle = .overFullScreen
        resultVC.modalTransitionStyle = .crossDissolve
        present(resultVC, animated: true)
    }
    
    private func bgAnimation() {
        var color = UIColor()
        
        if isWon { color = #colorLiteral(red: 0.5, green: 1, blue: 0.6666666667, alpha: 1) } else { color = #colorLiteral(red: 1, green: 0.5, blue: 0.5, alpha: 1) }
        
        UIView.animate(withDuration: 0.3, delay: 0) {
            self.view.backgroundColor = color
            self.view.backgroundColor = .white
        }
    }
    
}
