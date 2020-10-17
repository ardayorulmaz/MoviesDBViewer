//
//  GenreResponseObject.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import Foundation
import Foundation

// MARK: - GenreResponse
struct GenreResponse: Codable {
    var genres: [Genre]?
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
}

enum GenreMedia :String{
    case TV = "TV"
    case Movie = "MOVIE"
    
}
