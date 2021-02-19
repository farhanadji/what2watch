//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Foundation

public struct Movie: Equatable, Identifiable {
    public let id: Int
    public let backdropPath: String
    public let title: String
    public let posterPath: String
    public let releaseDate: String
    
    public init(id: Int, backdropPath: String, title: String, posterPath: String, releaseDate: String) {
        self.id = id
        self.backdropPath = backdropPath
        self.title = title
        self.posterPath = posterPath
        self.releaseDate = releaseDate
    }
}
