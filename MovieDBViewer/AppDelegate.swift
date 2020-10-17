//
//  AppDelegate.swift
//  MovieDBViewer
//
//  Created by ArdaY on 16/10/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        //Function fow initalizing apps main flow
        self.openMainFlow()
        return true
    }

   

    func openMainFlow(){
       
        
        
        let nav = MainPageViewController()
                window?.backgroundColor = .white
                nav.view.frame = self.window?.frame ?? CGRect.zero
                //
                
                UIView.transition(with: self.window!, duration: 0.3, options: .curveEaseIn, animations: {
                    self.window?.rootViewController = nav
                }, completion: { (isFinished) in
                })



        
    }
}

