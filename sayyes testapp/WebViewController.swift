//
//  WebViewController.swift
//  sayyes testapp
//
//  Created by Alex Rudoi on 6/5/21.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let url = URL(string: "https://google.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToUrl(url: url!.absoluteString)
    }
    
    private func goToUrl(url: String) {
        if let url = URL(string: "\(url)") {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
            webView.becomeFirstResponder()
            print("URL loaded succesfully")
        } else {
            print("Something went wrong. Try again")
        }
    }

}
