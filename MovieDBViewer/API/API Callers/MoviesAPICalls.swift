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
    
    //Extending the call here to benefit from moviedb's api to avoid two extra calls to server. Using append to response to get videos and credits
    static func getDetailExtended(id : Int,
                          success:@escaping (MovieDetailExtended?) -> Void,
                          failure:@escaping (Error?) -> Void){
     
     MovieDBViewerAPI.sharedAPI.get("movie/\(String(id))"+ConfigurationDataHandler.shared.APIKey()+"&language=en-US&append_to_response=videos%2Ccredits", parameters: nil, success: success, failure: failure);

    }
}
