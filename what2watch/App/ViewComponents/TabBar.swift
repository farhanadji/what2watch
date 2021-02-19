//
//  TabBar.swift
//  what2watch
//
//  Created by Farhan Adji on 12/02/21.
//

import SwiftUI
import Home
import Core
import Favorite

struct TabBar: View {
    @EnvironmentObject var homePresenter: Home.HomePresenter<Interactor<Core.Endpoints.Gets, [Core.Movie], HomeRepository<HomeRemoteDataSource, MovieTransformer>>>
    
    @EnvironmentObject var favoritePresenter: FavoritePresenter<Interactor<Any, [Movie], FavoriteRepository<FavoriteLocaleDataSource, FavoriteTransformer>>, Interactor<Int, Bool, UpdateFavoriteRepository<FavoriteLocaleDataSource>>>
    
    @SwiftUI.State var selectedTab: Tab = .home
    @SwiftUI.State var showTabBar: Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $selectedTab) {
                HomeView(presenter: homePresenter, showTabBar: $showTabBar)
                    .tag(Tab.home)
                
                FavoriteView(presenter: favoritePresenter, showTabBar: $showTabBar)
                    .tag(Tab.favorite)
                
                AboutView()
                    .tag(Tab.profile)
            }
            
            if showTabBar {
                HStack(spacing: 0) {
                    TabButton(forTab: .home, selected: $selectedTab)
                    Spacer(minLength: 0)
                    TabButton(forTab: .favorite, selected: $selectedTab)
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    TabButton(forTab: .profile, selected: $selectedTab)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(Color.white)
                .clipShape(Capsule())
                .padding(.horizontal, 25)
                .shadow(color: Color.black.opacity(0.3), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.5)))
            }
        }
    }
}

enum Tab {
    case home
    case favorite
    case profile
}


struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
