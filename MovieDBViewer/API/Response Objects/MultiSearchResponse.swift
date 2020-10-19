//
//  MultiSearchResponse.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import Foundation
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - MultiSearchResponse
struct MultiSearchResponse: Codable {
    var page, totalResults, totalPages: Int?
    var results: [Result]?

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct Result: Codable {
    var knownForDepartment: String?
    var id: Int
    var name: String?
    var knownFor: [Result]?
    var popularity: Double?
    var profilePath: String?
    var gender: Int?
    var mediaType: MediaType
    var adult: Bool?
    var posterPath: String?
    var voteCount: Int?
    var video: Bool?
    var backdropPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIDS: [Int]?
    var title: String?
    var voteAverage: Double?
    var overview, releaseDate, originalName: String?
    var originCountry: [String]?
    var firstAirDate: String?

    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case id, name
        case knownFor = "known_for"
        case popularity
        case profilePath = "profile_path"
        case gender
        case mediaType = "media_type"
        case adult
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case video
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
        case originalName = "original_name"
        case originCountry = "origin_country"
        case firstAirDate = "first_air_date"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}




