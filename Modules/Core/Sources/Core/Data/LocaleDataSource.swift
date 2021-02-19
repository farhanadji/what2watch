//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Combine

public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response
    
    func list() -> AnyPublisher<[Response], Error>
    func add(entities: Response) -> AnyPublisher<Bool, Error>
    func find(id: Request) -> AnyPublisher<Bool, Error>
    func update(id: Request) -> AnyPublisher<Bool, Error>
}
