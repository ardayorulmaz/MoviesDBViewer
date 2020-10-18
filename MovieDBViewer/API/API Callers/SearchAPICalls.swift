//
//  SearchAPIcalls.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation
class SearchAPICalls: NSObject {
    
   // API Call for searching by keywords for movies, tv shows or actors
    static func multiSearch(keyword : String, page : Int,
                         success:@escaping (MultiTypeResponse?) -> Void,
                         failure:@escaping (Error?) -> Void){
      /// make the call
    MovieDBViewerAPI.sharedAPI.get("search/multi"+ConfigurationDataHandler.shared.APIKey()+"&language=en-US&query+\(keyword)&page=\(String(page))&include_adult=false", parameters: nil, success: success, failure: failure);

   }
    
}
