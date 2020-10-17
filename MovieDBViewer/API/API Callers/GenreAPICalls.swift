//
//  GenreAPICalls.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation
import Foundation

class GenreAPICalls: NSObject {
    
   // API Call for getting current genres by type (movie or tv)
   static func getGenres(media : String,
                         success:@escaping (GenreResponse?) -> Void,
                         failure:@escaping (Error?) -> Void){
      /// make the call
    MovieDBViewerAPI.sharedAPI.get("genre/\(media)/list?+ConfigurationDataHandler.shared.APIkey()+language=en-US", parameters: nil, success: success, failure: failure);

   }
    
}
