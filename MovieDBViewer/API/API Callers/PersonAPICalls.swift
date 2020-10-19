//
//  PersonDetailAPICAlls.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import Foundation
class PersonDetailAPICAlls: NSObject
{
    static func getDetailExtended(id : Int,
                             success:@escaping (PersonDetail?) -> Void,
                             failure:@escaping (Error?) -> Void){
        
        MovieDBViewerAPI.sharedAPI.get("person/\(String(id))"+ConfigurationDataHandler.shared.APIKey()+"&language=en-US&append_to_response=credits", parameters: nil, success: success, failure: failure);
    
       }

    
}
