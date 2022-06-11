//
//  AddMoviesMiddleware.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import Foundation
import UIKit

class AddMoviesMiddleware {
    var moviesData = [Movies]()
    func addNewMovies(moviesTitle: String, movieYear: String, movieImage: UIImage, movieRating: String, movieGenre: String) {
        moviesData.append(Movies(movieTitle: moviesTitle, movieYear: movieYear, movieImage: movieImage, movieRating: movieRating, movieGenre: movieGenre))
    }
    
}