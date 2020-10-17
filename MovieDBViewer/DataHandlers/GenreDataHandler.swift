//
//  GenreDataHandler.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation


class GenreDataHandler: NSObject {
    
    static let sharedHandler: GenreDataHandler = {
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
        guard let jsonString =  UserDefaults.standard.string(forKey: key ?? self.movieGenreDataKey )else{
            return nil
        }
        let jsonData = jsonString.data(using: .utf8)!
        let decoder = JSONDecoder()
        let data = try! decoder.decode(GenreResponse.self, from: jsonData)
        return data
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
    
    func getTVGenreDataFromServer() {
        
        GenreAPICalls.getGenres(media: "tv", success: { (response) in
            
            guard let data = response else {
                return
            }
            self.setGenreDataFromResponse(data, media : .TV)
            
        }) { (error) in
            
        }
    }
    func getMovieGenreDataFromServer() {
        
        GenreAPICalls.getGenres(media: "movie", success: { (response) in
            
            guard let data = response else {
                return
            }
            self.setGenreDataFromResponse(data, media : .Movie)
            
        }) { (error) in
            
        }
    }
    
}


