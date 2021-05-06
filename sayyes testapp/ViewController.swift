//
//  ViewController.swift
//  sayyes testapp
//
//  Created by Alex Rudoi on 27/4/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBG()
        setElements()
    }
    
    func setElements() {
        //Title label
        titleLabel.layer.shadowColor = UIColor.black.cgColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 2)
        titleLabel.layer.shadowRadius = 24
        titleLabel.layer.shadowOpacity = 0.24
    }
    
    func setBG() {
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "bg")
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }

    @IBAction func startTapped(_ sender: UIButton) {
        let gameVC = storyboard!.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        gameVC.modalTransitionStyle = .crossDissolve
        present(gameVC, animated: true)
    }
    
    @IBAction func webViewTapped(_ sender: UIButton) {
        let webVC = storyboard!.instantiateViewController(withIdentifier: "WebViewController")
        present(webVC, animated: true)
    }
}

