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
        self.openLandingFlow()
        let group = DispatchGroup()
                
                group.enter()
        GenreDataHandler.shared.getTVGenreDataFromServer() {
            
            
            group.leave()
        }
        group.enter()
        GenreDataHandler.shared.getMovieGenreDataFromServer(){
            
            
            group.leave()
        }
                group.notify(queue: DispatchQueue.main) {
                    self.openMainFlow()

                    
                }

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
    
    func openLandingFlow(){
        guard let mainWindow = self.window else {
            return
        }
        let nav = LandingPageViewController()
      
                mainWindow.backgroundColor = .white
                nav.view.frame = mainWindow
                    .frame
                //
                
                UIView.transition(with: mainWindow, duration: 0.3, options: .curveEaseIn, animations: {
                    self.window?.rootViewController = nav
                }, completion: { (isFinished) in
                })
                
    }}

