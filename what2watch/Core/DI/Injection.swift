//
//  Injection.swift
//  what2watch
//
//  Created by Farhan Adji on 14/02/21.
//

import UIKit
import RealmSwift
import Core
import Home
import Detail
import Favorite

final class Injection: NSObject {
    func provideHome<U: UseCase>() -> U where U.Request == Core.Endpoints.Gets, U.Response == [Core.Movie] {
        let remote = HomeRemoteDataSource()
        let mapper = MovieTransformer()
        
        let repo = HomeRepository(remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repo) as! U
    }
    
    func provideDetail<U: UseCase>() -> U where U.Request == String, U.Response == MovieDetail {
        let remote = DetailRemoteDataSource()
        let mapper = MovieDetailMapper()
        let repo = DetailRepository(remoteDataSource: remote, mapper: mapper)
        
        return Interactor(repository: repo) as! U
    }
    
    func provideDetailFavorite<U: UseCase>() -> U where U.Request == DetailFavoriteAction, U.Response == Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let locale = DetailFavoriteLocaleDataSource(realm: appDelegate.realm)
        let mapper = MovieDetailMapper()
        let repo = DetailFavoriteRepository(localDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repo) as! U
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [Movie] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = FavoriteLocaleDataSource(realm: appDelegate.realm)
        let mapper = FavoriteTransformer()
        let repo = FavoriteRepository(localDataSource: locale, mapper: mapper)
        
        return Interactor(repository: repo) as! U
    }
    
    func provideUpdateFavorite<U: UseCase>() -> U where U.Request == Int, U.Response == Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let locale = FavoriteLocaleDataSource(realm: appDelegate.realm)

        let repo = UpdateFavoriteRepository(localDataSource: locale)
        
        return Interactor(repository: repo) as! U
    }
}
