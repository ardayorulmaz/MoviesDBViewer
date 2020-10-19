//
//  GenreDataHandler.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation

//*A singleton for  handling genre data, its calling fresh data from server each launch and handles genre string generating
class GenreDataHandler: NSObject {
    
    static let shared: GenreDataHandler = {
        let instance = GenreDataHandler()
        
        return instance
    }()
    
    // MARK: -GenreSaveDataKey
    let movieGenreDataKey = "GENRE_MOVIE_DATA_STRING"
    let tvGenreDataKey = "TV_MOVIE_DATA_STRING"
    
    func getGenreDataFor(media : GenreMedia) -> GenreResponse? {
        //Defining key for requested media type
        var key : String?
        switch media {
        case .TV:
            key = self.tvGenreDataKey
        case .Movie:
            key = self.movieGenreDataKey
        }
        //Calling saved genre data from userdetails
        guard let jsonString =  UserDefaults.standard.string(forKey: key ?? self.movieGenreDataKey )else{
            return nil
        }
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let data = try! decoder.decode(GenreResponse.self, from: jsonData)
        return data
    }
    // A stronfg
    func getGenreString(ids : [Int], genre : GenreMedia)->String?{
            guard let genreData = self.getGenreDataFor(media: genre) else {
                return nil
            }
           var stringToReturn : String = ""
           
           for id in ids {
    if let genreArray = genreData.genres {
    for item in genreArray {

    if item.id == id {
        stringToReturn += (item.name ?? "") + (ids.last == id ? "" : "/" )
    }
    }
    }
    }
        return stringToReturn
    }
                 func setGenreDataFromResponse( _ data:GenreResponse, media : GenreMedia){
        self.setGenreData(data, media : media)
    }
    
    func setGenreData( _ data:GenreResponse, media : GenreMedia){
        //Defining key for requested media type
        var key : String?
        switch media {
        case .TV:
            key = self.tvGenreDataKey
        case .Movie:
            key = self.movieGenreDataKey
        }
        let encoder = JSONEncoder()
        let encoded = try! encoder.encode(data)
        UserDefaults.standard.set(String(data: encoded, encoding: .utf8)!, forKey: key ?? self.movieGenreDataKey )
    }
    
    
   
        
        //ServerCall for tv genres
    
    func getTVGenreDataFromServer( endBlock: @escaping () -> Void = {}) {
        
        GenreAPICalls.getGenres(media: "tv", success: { (response) in
            
            guard let data = response else {
                return
            }
            self.setGenreDataFromResponse(data, media : .TV)
          endBlock()
        }) { (error) in
            endBlock()
        }
        
    }
    
    //Server call for move genres
    func getMovieGenreDataFromServer( endBlock: @escaping () -> Void = {}) {
        
        GenreAPICalls.getGenres(media: "movie", success: { (response) in
            
            guard let data = response else {
                return
            }
            self.setGenreDataFromResponse(data, media : .Movie)
            endBlock()
        }) { (error) in
            endBlock()
        }
    }
    
}


