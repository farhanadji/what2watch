//
//  HomeRouter.swift
//  what2watch
//
//  Created by Farhan Adji on 14/02/21.
//

import SwiftUI
import Detail
import Core

class HomeRouter {
    func makeDetailView(for movie: Movie) -> some View {
        let detailUseCase: Interactor<String, MovieDetail,  DetailRepository<DetailRemoteDataSource, MovieDetailMapper>> = Injection.init().provideDetail()
        
        let favoriteUseCase: Interactor<DetailFavoriteAction, Bool, DetailFavoriteRepository<DetailFavoriteLocaleDataSource, MovieDetailMapper>> = Injection.init().provideDetailFavorite()
        
        let presenter = DetailPresenter(detailUseCase: detailUseCase, favoriteUseCase: favoriteUseCase)
        return DetailView(presenter: presenter, movie: movie)
    }
}
