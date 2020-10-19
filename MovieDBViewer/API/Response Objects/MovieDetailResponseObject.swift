//
//  MovieDetailResponseObject.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import Foundation
// MARK: - Movie Detail
struct MovieDetailExtended: Codable {
    var adult: Bool?
    var backdropPath: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var id: Int?
    var imdbID, originalLanguage, originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var productionCompanies: [ProductionCompany]?
    var productionCountries: [ProductionCountry]?
    var releaseDate: String?
    var revenue, runtime: Int?
    var spokenLanguages: [SpokenLanguage]?
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var credits: Credits?
    var videos : Videos?
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case credits
        case videos
    }
}


// MARK: - Credits
struct Credits: Codable {
    var cast: [Cast]?
    var crew: [Crew]?
}

// MARK: - Cast
struct Cast: Codable {
    var castID: Int?
    var character, creditID: String?
    var gender, id: Int?
    var name: String?
    var order: Int?
    var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case gender, id, name, order
        case profilePath = "profile_path"
    }
}

// MARK: - Crew
struct Crew: Codable {
    var creditID: String?
    var department: Department?
    var gender, id: Int?
    var job, name: String?
    var profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
}

enum Department: String, Codable {
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    var id: Int?
    var logoPath: String?
    var name, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    var iso31661, name: String?

    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
}


// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    var iso639_1, name: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}
// MARK: - Videos
struct Videos: Codable {
    var results: [VideoResult]
}
// MARK: - VideoResult
struct VideoResult: Codable {
    var id : String
    var iso_639_1, iso_3166_1, key: String?
    var name, site: String?
    var size: Int?
    var type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case iso_639_1 = "iso_639_1"
        case iso_3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }
}

