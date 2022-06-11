//
//  MoviesMiddleware.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import Foundation

class MoviesMiddleware {
    var moviesData = [Movies]()
    func appendToBasket(newMovie: Movies) {
        moviesData.append(newMovie)
    }
}
