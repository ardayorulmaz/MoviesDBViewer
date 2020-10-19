//
//  DecodableClassFamily.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import Foundation
protocol DecodableClassFamily : Decodable {
    associatedtype BaseType : Decodable
    static var discriminator: Discriminator { get }

    func getType() -> BaseType.Type
}

enum Discriminator : String, CodingKey {
    case mediaType = "media_type"
}

enum SearchResultFamily : String, DecodableClassFamily {

    typealias BaseType = SearchResult

    case movie
    case tv
case person

    static var discriminator: Discriminator { return .mediaType }

    func getType() -> SearchResult.Type {
        switch self {
        case .movie: return MovieData.self
        case .person: return PersonData.self
case .tv : return TVData.self
        }
    }
}


extension KeyedDecodingContainer {
    func decodeHeterogeneousArray<F : DecodableClassFamily>(family: F.Type, forKey key: K) throws -> [F.BaseType] {

        var container = try nestedUnkeyedContainer(forKey: key)
        var containerCopy = container
        var items: [F.BaseType] = []
        while !container.isAtEnd {

            let typeContainer = try container.nestedContainer(keyedBy: Discriminator.self)
            do {
                let family = try typeContainer.decode(F.self, forKey: F.discriminator)
                let type = family.getType()
                // decode type
                let item = try containerCopy.decode(type)
                items.append(item)
            } catch let e as DecodingError {
                switch e {
                case .dataCorrupted(let context):
                    if context.codingPath.last?.stringValue == F.discriminator.stringValue {
                        print("WARNING: Unhandled key: \(context.debugDescription)")
                        _ = try containerCopy.decode(F.BaseType.self)
                    } else {
                        throw e
                    }
                default: throw e
                }
            }
        }
        return items
    }
}



