//
//  PopularMoviesApiCalls.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation

class MovieAPICalls: NSObject {
    
   // API Call for getting current popular movies by page
   static func getPopular(page : Int,
                         success:@escaping (PopularMoviesResponse?) -> Void,
                         failure:@escaping (Error?) -> Void){
      /// make the call
    MovieDBViewerAPI.sharedAPI.get("movie/popular"+ConfigurationDataHandler.shared.APIKey()+"&language=en-US&page=\(String(page))", parameters: nil, success: success, failure: failure);

   }
    
}
