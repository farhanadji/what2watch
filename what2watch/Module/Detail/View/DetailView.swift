//
//  DetailView.swift
//  what2watch
//
//  Created by Farhan Adji on 11/02/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Core
import Detail

struct DetailView: View {
    @Environment(\.presentationMode) var presentation
    @ObservedObject var presenter: DetailPresenter< Interactor<String, MovieDetail,  DetailRepository<DetailRemoteDataSource, MovieDetailMapper>>, Interactor<DetailFavoriteAction, Bool, DetailFavoriteRepository<DetailFavoriteLocaleDataSource, MovieDetailMapper>>>
    var movie: Movie
    
    var body: some View {
        ScrollView {
            content
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
                        presenter.getDetail(id: String(movie.id))
                        presenter.checkMovieFavorite(id: movie.id)
                    }
                }
        }
        .navigationBarTitle(presenter.movieDetail?.title ?? "What2Watch", displayMode: .inline)
    }
}

extension DetailView {
    var content: AnyView {
        switch self.presenter.state {
        case .idle, .loading:
            return AnyView(ProgressView())
        case .loaded:
            return movieDetailContent
        case .error, .empty:
            return AnyView(EmptyView())
        }
    }

    var movieDetailContent: AnyView {
        return AnyView(
            LazyVStack {
                VStack {
                    ZStack(alignment: .topLeading) {
                        WebImage(url: URL(string: presenter.movieDetail?.backdropPath ?? ""))
                            .resizable()
                            .placeholder {
                                Rectangle().foregroundColor(Color.gray.opacity(0.25))
                            }
                            .indicator(.activity)
                            .scaledToFill()
                            .frame(height: 380)
                            .clipped()
                            .blur(radius: 5)
                            .overlay(Color.black.opacity(0.5))

                        VStack(alignment: .center, spacing: 0) {
                            WebImage(url: URL(string: presenter.movieDetail?.posterPath ?? ""))
                                .resizable()
                                .placeholder {
                                    Rectangle()
                                        .foregroundColor(Color.gray.opacity(0.5))
                                }
                                .indicator(.activity)
                                .scaledToFit()
                                .frame(width: 150, height: 220)
                                .shadow(color: .black, radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)

                            Text(presenter.movieDetail?.title ?? "-")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            Text(presenter.movieDetail?.releaseDate ?? "-")
                                .foregroundColor(Color.white.opacity(0.6))
                                .padding(.bottom, 5)

                            Text(presenter.movieDetail?.genres ?? "-")
                                .foregroundColor(Color.white)
                                .font(.system(size: 14))
                        }
                        .padding(.top, 40)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }

                Group {
                    Section(header:
                                HStack {
                                    Text("Overview")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                    Spacer()
                                    Button(action: {
                                        if self.presenter.isFavorite {
                                            self.presenter.removeFromFavorite(id: movie.id)
                                        } else {
                                            self.presenter.addToFavorite()
                                        }
                                    }, label: {
                                        FavoriteIcon(isFavorite: self.$presenter.isFavorite, isDetailView: true)
                                    })
                                }
                                .padding(.top)
                    ) {
                        Text(presenter.movieDetail?.overview ?? "-")
                            .font(.system(size: 15))
                            .foregroundColor(Color.black.opacity(0.7))
                    }

                    Section(header:
                                HStack {
                                    Text("Status")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                    ) {
                        HStack {
                        Text(presenter.movieDetail?.status ?? "-")
                            .font(.system(size: 15))
                            .foregroundColor(Color.black.opacity(0.7))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black.opacity(0.7), lineWidth: 2)
                            )
                            Spacer()
                        }
                    }

                    Section(header:
                                HStack {
                                    Text("Statistics")
                                        .font(.system(size: 20))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                    ) {
                        HStack {
                            StatisticItem(title: "Popularity", decimalNumber: presenter.movieDetail?.popularity)
                            StatisticItem(title: "Vote count", normalNumber: presenter.movieDetail?.voteCount)
                            StatisticItem(title: "Vote average", decimalNumber: presenter.movieDetail?.voteAverage)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 5)
            })
    }
}

struct StatisticItem: View {
    var title: String
    var decimalNumber: Double?
    var normalNumber: Int?
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color.black.opacity(0.5))

            normalNumber.map { (number) in
                Text(String(number))
                    .font(.system(size: 18))
                    .foregroundColor(Color.black.opacity(0.7))
            }

            decimalNumber.map { (number)  in
                Text(String(number))
                    .font(.system(size: 18))
                    .foregroundColor(Color.black.opacity(0.7))
            }
        }
        .padding()
    }
}
