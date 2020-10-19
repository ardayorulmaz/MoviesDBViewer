//
//  MultiTypeResponseObject.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import Foundation
class MultiTypeResponse : Codable{
    var page : Int?
var totalResults : Int?
var totalPages: Int?
    var results: [SearchResult]?
    
    
    required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           self.results = try container.decodeHeterogeneousArray(family: SearchResultFamily.self, forKey: .results)
       }


}
class SearchResult : Codable,CustomStringConvertible {
    var description: String {
        return "Result ???"
    }
    
    var id: Int
    var mediaType  : String
   
 enum CodingKeys : String, CodingKey, Codable{
case id
case mediaType = "media_type"
 }
    
    
//    init(type:String){
//        id = Int(UUID().uuidString
//        self.mediaType = type
//    }
}


// MARK: - Welcome
class PersonData: SearchResult {
    var knownForDepartment: String?
    var name: String?
    var knownFor: [MovieData]?
    var popularity: Double?
    var profilePath: String?
    var gender: Int?
    var adult: Bool?

    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case id, name
        case knownFor = "known_for"
        case popularity
        case profilePath = "profile_path"
        case gender
        case mediaType = "media_type"
        case adult
    }
}

class TVData: SearchResult{
    var originalName: String?
    var genreIDS: [Int]?
    var  name: String?
    var popularity: Double?
    var originCountry: [String]?
    var voteCount: Int?
    var firstAirDate: String?
    var backdropPath: String?
    var originalLanguage: String?
    var voteAverage: Int?
    var overview: String?
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name, popularity
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id
        case voteAverage = "vote_average"
        case overview
        case posterPath = "poster_path"
    }
}



class MovieData: SearchResult{
    var posterPath: String?
    var popularity: Double = 0
    var voteCount: Int?
    var video: Bool?
    var adult: Bool?
    var backdropPath: String?
    var originalLanguage, originalTitle: String?
    var genreIDS: [Int]?
    var title: String?
    var voteAverage: Double?
    var overview, releaseDate: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case mediaType = "media_type"
        case id, adult
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }

}





