//
//  AppDelegate.swift
//  sayyes testapp
//
//  Created by Alex Rudoi on 27/4/21.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var params: Params?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureInitialViewController()
        
        return true
    }
    
    private func setControllers() {
        
        let initialViewController: UIViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        window = UIWindow()
        
        if params?.active ?? false {
            let mainViewController = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            mainViewController.url = URL(string: params!.link)
            initialViewController = mainViewController
        } else {
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
            initialViewController = loginViewController
        }
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    private func configureInitialViewController() {
        
        let request = AF.request("https://raw.githubusercontent.com/dkainm/bridge-builder/master/params.json")
        
        request.responseDecodable(of: Params.self) { (response) in
            guard let params = response.value else {
                self.setControllers()
                return
            }
            self.params = params
            self.setControllers()
        }
        
    }
    
}

