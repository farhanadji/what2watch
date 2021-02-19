//
//  HomeView.swift
//  what2watch
//
//  Created by Farhan Adji on 11/02/21.
//

import SwiftUI
import Core
import Home

struct HomeView: View {
    @ObservedObject var presenter: Home.HomePresenter<Interactor<Core.Endpoints.Gets, [Core.Movie], HomeRepository<HomeRemoteDataSource, MovieTransformer>>>
    
    @Binding var showTabBar: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    Section(header:
                                HStack {
                                    Text("Popular")
                                        .font(.system(size: 23))
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                    ) {
                        ScrollView(.horizontal, showsIndicators: false) {
                                popularContent
                                    .onAppear(perform: {
                                        presenter.getPopularMovies()
                                    })
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    Section(header:
                                HStack {
                                    Text("Featured")
                                        .font(.system(size: 23))
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                    ) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            featuredContent
                                .onAppear(perform: {
                                    self.presenter.getFeaturedMovies()
                                })
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    Section(header:
                                HStack {
                                    Text("Now Playing")
                                        .font(.system(size: 23))
                                        .fontWeight(.semibold)
                                    
                                    Spacer()
                                }
                    ) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            nowPlayingContent
                                .onAppear(perform: {
                                    self.presenter.getNowPlayingMovies()
                                })
                        }
                    }
                }
                .padding()
                .padding(.bottom, 60)
            }
            .onAppear(perform: {
                showTabBar = true
            })
            
            .navigationBarTitle("What2Watch")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
extension HomeView {
    private var popularContent: AnyView {
        switch self.presenter.popularState {
        case .idle, .loading:
            return AnyView(ProgressView())
        case .loaded:
            return AnyView(LazyHStack(spacing: 20) {
                ForEach(self.presenter.popularMovies, id: \.id) { movie in
                    ZStack {
                        linkBuilder(for: movie) {
                            MovieCard(movie: movie)
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            showTabBar = false
                        }))
                    }
                }
            })
        case .error, .empty:
            return AnyView(EmptyView())
        }
    }
    
    private var nowPlayingContent: AnyView {
        switch self.presenter.nowPlayingState {
        case .idle, .loading:
            return AnyView(ProgressView())
        case .loaded:
            return AnyView(LazyHStack(spacing: 20) {
                ForEach(self.presenter.nowPlayingMovies, id: \.id) { movie in
                    ZStack {
                        linkBuilder(for: movie) {
                            MovieCard(movie: movie)
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            showTabBar = false
                        }))
                    }
                }
            })
        case .error, .empty:
            return AnyView(EmptyView())
        }
    }
    
    private var featuredContent: AnyView {
        switch self.presenter.featuredState {
        case .idle, .loading:
            return AnyView(ProgressView())
        case .loaded:
            return AnyView(LazyHStack(spacing: 20) {
                ForEach(self.presenter.featuredMovies, id: \.id) { movie in
                    ZStack {
                        linkBuilder(for: movie) {
                            FeaturedMovieCard(movie: movie)
                        }
                        .simultaneousGesture(TapGesture().onEnded({
                            showTabBar = false
                        }))
                    }
                }
            })
        case .error, .empty:
            return AnyView(EmptyView())
        }
    }
}

extension HomeView {
    func linkBuilder<Content: View>(
        for movie: Movie,
        @ViewBuilder content: () -> Content
    ) -> some View {
        
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: movie)
        ) { content() }
        .buttonStyle(PlainButtonStyle())
    }
}
