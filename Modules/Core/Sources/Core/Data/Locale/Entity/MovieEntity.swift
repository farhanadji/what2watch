//
//  File.swift
//  
//
//  Created by Farhan Adji on 19/02/21.
//

import Foundation
import RealmSwift

public class MovieEntity: Object {
    @objc public dynamic var id: Int = 0
    @objc public dynamic var backdropPath: String = ""
    @objc public dynamic var title: String = ""
    @objc public dynamic var posterPath: String = ""
    @objc public dynamic var releaseDate: String = ""
    
    public required override init() { }
    
    public override class func primaryKey() -> String? {
        return "id"
    }
}
