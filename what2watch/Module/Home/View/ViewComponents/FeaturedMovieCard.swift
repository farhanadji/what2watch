//
//  FeaturedMovieCard.swift
//  what2watch
//
//  Created by Farhan Adji on 12/02/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Home
import Core

struct FeaturedMovieCard: View {
    var movie: Core.Movie
    var body: some View {
        VStack(alignment: .leading) {
            WebImage(url: URL(string: movie.posterPath))
                .resizable()
                .placeholder {
                    Rectangle().foregroundColor(Color.gray.opacity(0.5))
                }
                .indicator(.activity)
                .scaledToFill()
                .frame(width: 260, height: 170)
                .overlay(
                    ZStack(alignment: .bottomLeading) {
                        LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .lineLimit(1)
                            
                            Text(movie.releaseDate)
                                .font(.system(size: 13))
                                .foregroundColor(.white)
                        }
                        .padding()
                    }
                )
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.5), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            
            
        }
    }
}
