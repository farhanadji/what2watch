//
//  MovieCard.swift
//  what2watch
//
//  Created by Farhan Adji on 12/02/21.
//

import SwiftUI
import SDWebImageSwiftUI
import Home
import Core

struct MovieCard: View {
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
                .frame(width: 150, height: 220)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(color: Color.black.opacity(0.2), radius: 4, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
            
            Text(movie.title)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .lineLimit(1)
            
            Text(movie.releaseDate)
                .font(.system(size: 14))
                .foregroundColor(Color.black.opacity(0.6))
                .padding(.top, 1)
        }
        .frame(width: 150)
    }
}
