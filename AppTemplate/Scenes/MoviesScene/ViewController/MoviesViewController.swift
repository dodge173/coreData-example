//
//  MoviesViewController.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import UIKit

class MoviesViewController: UIViewController {
    // MARK: - Props
    var middleware = MoviesMiddleware()
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyLabel: UILabel!
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.loadData()
            self.tableView.reloadData()
            self.handleEmpty()
        }
    }
    // MARK: - Main Functions
    func initView() {
        tableViewConfig()
        handleEmpty()
    }
    func initViewModel() {
        loadData()
    }
    // MARK: - View Functions
    func tableViewConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.tableFooterView = nil
        tableView.tableHeaderView = nil
        tableView.registerCellNib(cellClass: MoviesTableViewCell.self)
    }
    func handleEmpty() {
        if middleware.moviesData.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
        } else {
            tableView.isHidden = false
            emptyLabel.isHidden = true
        }
    }
    // MARK: - Data Functions
    func loadData() {
        guard let movieData = AppManger.shared.moviesData else {return}
        middleware.appendToBasket(newMovie: movieData)
    }
    // MARK: - IBActions
    @IBAction func addNewMovies(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AddMoviesSB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddMoviesViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// MARK: - TableViewDataSource
extension MoviesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return middleware.moviesData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as MoviesTableViewCell
        let yearString = String(middleware.moviesData[indexPath.row].movieYear)
        cell.textLabel?.text = middleware.moviesData[indexPath.row].movieTitle
        cell.detailTextLabel?.text = yearString
        cell.imageView?.image = middleware.moviesData[indexPath.row].movieImage
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
// MARK: - TableViewDelegate
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = middleware.moviesData[indexPath.row]
        let storyboard = UIStoryboard(name: "DetailsSB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.middleware.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
