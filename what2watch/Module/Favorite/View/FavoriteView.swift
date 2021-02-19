//
//  FavoriteView.swift
//  what2watch
//
//  Created by Farhan Adji on 11/02/21.
//

import SwiftUI
import Core
import Favorite

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter<Interactor<Any, [Movie], FavoriteRepository<FavoriteLocaleDataSource, FavoriteTransformer>>, Interactor<Int, Bool, UpdateFavoriteRepository<FavoriteLocaleDataSource>>>
    
    @Binding var showTabBar: Bool
    var body: some View {
        NavigationView {
            ScrollView {
               content
                .padding(.top)
                .onAppear(perform: {
                    showTabBar = true
                    self.presenter.getFavoriteMovies()
                })
            }
            
            .navigationBarTitle("Favorite", displayMode: .inline)
        }
    }
}

extension FavoriteView {
    private var content: AnyView {
        switch self.presenter.state {
        case .idle, .loading:
            return AnyView(ProgressView())
        case .loaded:
            return favoriteContent
        case .empty:
            return emptyState
        case .error:
            return AnyView(EmptyView())
        }
    }
    
    private var emptyState: AnyView {
       return AnyView(VStack {
            Spacer()
            Image(systemName: "tornado")
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            Text("You don't have any favorite movie.")
                .font(.system(size: 22))
                .fontWeight(.bold)
            Spacer()
        })
    }
    
    private var favoriteContent: AnyView {
        return AnyView(LazyVStack(spacing: 20) {
            ForEach(self.presenter.favoriteLists, id: \.id) { movie in
                ZStack {
                    linkBuilder(for: movie) {
                        FavoriteItem(movie: movie, removeAction: {
                            self.presenter.removeMovie(movieId: movie.id)
                        })
                    }
                    .simultaneousGesture(TapGesture().onEnded({
                        showTabBar = false
                    }))
                }
                Divider()
            }
        })
    }
}

extension FavoriteView {
    func linkBuilder<Content: View>(
        for movie: Movie,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: movie)
        ) { content() }
        .buttonStyle(PlainButtonStyle())
    }
}
