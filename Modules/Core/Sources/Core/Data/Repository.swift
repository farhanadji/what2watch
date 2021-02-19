//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import Combine

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request?) -> AnyPublisher<Response, Error>
}
