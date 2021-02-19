//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Request
    associatedtype Entity
    associatedtype Domain
    
    func transformResponsesToDomains(response: Response) -> Domain
    func transformEntitiesToDomains(entity: Entity) -> Domain
    func transformDomainToEntity(domain: Domain) -> Entity
}
