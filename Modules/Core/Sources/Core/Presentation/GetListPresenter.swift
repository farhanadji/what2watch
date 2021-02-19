//
//  File.swift
//  
//
//  Created by Farhan Adji on 18/02/21.
//

import SwiftUI
import Combine

public class GetListPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == [Response] {
    private var cancellables: Set<AnyCancellable> = []
    
    private let _useCase: Interactor
    
    @Published var list: [Response] = []
    @Published var errorMessage: String = ""
    @Published var state: State = .idle
    
    public init(useCase: Interactor) {
        _useCase = useCase
    }
    
    public func getList(request: Request?) {
        state = .loading
        _useCase.execute(request: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.state = .error
                case .finished:
                    self.state = .loaded
                }
            }, receiveValue: { list in
                self.list = list
            })
            .store(in: &cancellables)
        
    }
}

public enum State {
    case idle
    case loading
    case loaded
    case error
    case empty
}
