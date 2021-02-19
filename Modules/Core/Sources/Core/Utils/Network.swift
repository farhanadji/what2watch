//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Foundation

public struct API {
    public static let baseUrl = "https://api.themoviedb.org/3/movie/"
    public static let apiKey = "011476f22113ee2ae9d19f4d511997bc"
    public static let language = "en-US"
    public static let imageUrl = "https://image.tmdb.org/t/p/w500/"
}

public protocol Endpoint {
    var url: String { get }
}

public enum Endpoints {
    public enum Gets: Endpoint {
        case popular
        case featured
        case nowPlaying
        case detail(movieId: String)
        
        
        public var url: String {
            switch self {
            case .popular: return "\(API.baseUrl)popular?api_key=\(API.apiKey)&language=\(API.language)"
            case .featured: return "\(API.baseUrl)top_rated?api_key=\(API.apiKey)&language=\(API.language)"
            case .nowPlaying: return "\(API.baseUrl)now_playing?api_key=\(API.apiKey)&language=\(API.language)"
            case .detail(let movieId): return "\(API.baseUrl)\(movieId)?api_key=\(API.apiKey)&language=\(API.language)"
            }
        }
    }
}
