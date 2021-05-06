//
//  ResultViewController.swift
//  sayyes testapp
//
//  Created by Alex Rudoi on 6/5/21.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var bestLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    
    var best = 0
    var result = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bestLabel?.text = "BEST RESULT: \(best)"
        resultLabel?.text = "\(result)"
    }

    @IBAction func tryAgainTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
