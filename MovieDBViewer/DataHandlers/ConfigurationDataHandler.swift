//
//  ConfigurationDataHandler.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation

import UIKit
class ConfigurationDataHandler: NSObject {

   var fullPlist : NSDictionary!


  


   static let shared: ConfigurationDataHandler = {
       let instance = ConfigurationDataHandler()
       var nsDictionary: NSDictionary?
       if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") {


           instance.fullPlist = NSDictionary(contentsOfFile: path)
       }
       return instance
   }()


   // Returns Application's back end URL.

   func baseURL() -> String{

       guard let plist = fullPlist, let url = plist["baseURL"] as? String else{
           fatalError("could not find backEndURL on Configuration.plist")
       }
       return url
   }
   func imageBaseURL() -> String{

       guard let plist = fullPlist, let url = plist["ImageBaseURL"] as? String else{
           fatalError("could not find ImageBaseURL on Configuration.plist")
       }
       return url
   }

   func APIKey() -> String{

       guard let plist = fullPlist, let apiKey = plist["APIKey"] as? String else{
           fatalError("could not find APIKey on Configuration.plist")
       }
       return "?api_key="+apiKey
   }
}
