//
//  DetailsViewController.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Props
    lazy var middleware = DetailsMiddleWare()
    // MARK: - IBOutlets
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieGen: UILabel!
    @IBOutlet weak var MovieRate: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    // MARK: - Main Functions
    func initView() {
        initLabelsAndImages()
    }
    func initViewModel() {
        
    }
    // MARK: - Functions
    func initLabelsAndImages() {
        guard let movie = middleware.movie else {
            return
        }
        movieTitle.text = movie.movieTitle
        movieYear.text = movie.movieYear
        movieGen.text = movie.movieGenre
        MovieRate.text = movie.movieRating
        imageView.image = movie.movieImage
    }

}
