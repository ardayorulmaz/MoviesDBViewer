//
//  PersonResponseObjects.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import Foundation


// MARK: - PersonDetail
struct PersonDetail: Codable {
    var birthday, knownForDepartment: String?
    var deathday: String?
    var id: Int?
    var name: String?
    var credits: InCredits?
    var alsoKnownAs: [String]?
    var gender: Int?
    var biography: String?
    var popularity: Double?
    var placeOfBirth, profilePath: String?
    var adult: Bool?
    var imdbID: String?
    var homepage: String?

    enum CodingKeys: String, CodingKey {
        case birthday
        case knownForDepartment = "known_for_department"
        case deathday, id, name, credits
        case alsoKnownAs = "also_known_as"
        case gender, biography, popularity
        case placeOfBirth = "place_of_birth"
        case profilePath = "profile_path"
        case adult
        case imdbID = "imdb_id"
        case homepage
    }
}

// MARK: - InCredits
struct InCredits: Codable {
    var cast, crew: [CreditsOf]?
}

// MARK: - Cast
struct CreditsOf: Codable {
    var posterPath: String?
    var adult: Bool?
    var backdropPath: String?
    var voteCount: Int?
    var video: Bool?
    var id: Int?
    var popularity: Double?
    var genreIDS: [Int]?
    var originalLanguage: String?
    var title, originalTitle, releaseDate, character: String?
    var voteAverage: Double?
    var overview, creditID, department, job: String?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case backdropPath = "backdrop_path"
        case voteCount = "vote_count"
        case video, id, popularity
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case title
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case character
        case voteAverage = "vote_average"
        case overview
        case creditID = "credit_id"
        case department, job
    }
}
