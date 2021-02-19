//
//  ContentView.swift
//  what2watch
//
//  Created by Farhan Adji on 11/02/21.
//

import SwiftUI
import Core
import Home
import Favorite

struct ContentView: View {
    @EnvironmentObject var homePresenter: HomePresenter<Interactor<Endpoints.Gets, [Movie], HomeRepository<HomeRemoteDataSource, MovieTransformer>>>
    @EnvironmentObject var favoritePresenter: FavoritePresenter<Interactor<Any, [Movie], FavoriteRepository<FavoriteLocaleDataSource, FavoriteTransformer>>, Interactor<Int, Bool, UpdateFavoriteRepository<FavoriteLocaleDataSource>>>
    
    var body: some View {
        TabBar()
            .environmentObject(homePresenter)
            .environmentObject(favoritePresenter)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
