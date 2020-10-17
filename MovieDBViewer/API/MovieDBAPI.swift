//
//  MovieDBAPI.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation
import UIKit
import Alamofire
// import NotificationBannerSwift
class MovieDBViewerAPI: NSObject {
    
    
    var url : String{
        get{
          
            return "https://api.themoviedb.org/3/"
             
        }
    }

    var auth : String{
        get{
            
                return ConfigureDataHandler.shared.baseAuthorization()
              
        }
    }
 

    
    private override init() {}
    var session : Session!
    
    static let sharedAPI: MovieDBViewerAPI = {
        
        let instance = MovieDBViewerAPI()
        var sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval.init(100)
        instance.session = Session(configuration: sessionConfig, interceptor: MovieDBViewerAPIHelper())
        return instance
    }()
    
    
    
    
    //MARK: - Report Functions
    func post<T:Codable>(_ callPath:String,
                         parameters: [String: Any]?,
                         headers: HTTPHeaders? = nil,
                         success:@escaping (T) -> Void,
                         failure:@escaping (ErrorResponse?) -> Void,
                         afterCall:@escaping () -> Void = {}){
        
        
        /// merge url's from configure.plist and call path
        let url = ConfigureDataHandler.shared.baseUrl() + callPath
        
        ///make the post requests with parameter and encoding
        session.request(url, method: .post, parameters: parameters, encoding : JSONEncoding.default).validate().responseDecodable{ (response:AFDataResponse<T>)  in
            //                            print(response)
            //                            print(response.data)
            //                            print(response.response)
            switch response.result {
                
            case .success(let value):
                
                success(value)
                
            case .failure(let error):
                
                let generalError = ErrorResponse(statusCode: response.response?.statusCode, errorCode : error.responseCode, errorMessage: callPath + ": " + error.localizedDescription)
                failure(generalError)
                print(generalError)
            }
            
            
        }
    }
    
    /// Main get call
    ///
    /// - Returns: return object
    func get<T:Codable>(_ callPath:String,
                        parameters: [String: Any]?,
                        headers: HTTPHeaders? = nil,
                        success:@escaping (T) -> Void,
                        failure:@escaping (ErrorResponse?) -> Void,
                        afterCall:@escaping () -> Void = {}){
        
        //check login status and set the http headers accordingly
        
        let url = ConfigureDataHandler.shared.baseUrl() + callPath
        
        
        session.request(url, method: .get, parameters: parameters, encoding : JSONEncoding.default).validate().responseDecodable{ (response:AFDataResponse<T>)  in
            switch response.result {
                
            case .success(let value):
                success(value)
            case .failure(let error):
        
             let generalError = ErrorResponse(statusCode: response.response?.statusCode, errorCode : error.responseCode, errorMessage: callPath + ": " + error.localizedDescription)
                failure(generalError)
            }
        }
    }
   
    
    
}
