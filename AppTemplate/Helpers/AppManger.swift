//
//  AppManger.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import Foundation

class AppManger {
    static let shared = AppManger()
    private init () {}
    var moviesData: Moviess?
}
