//
//  MoviesViewController.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import UIKit

class MoviesViewController: UIViewController {
    // MARK: - Props
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
        if AppManger.shared.moviesData.isEmpty {
            tableView.isHidden = true
            emptyLabel.isHidden = false
        } else {
            tableView.isHidden = false
            emptyLabel.isHidden = true
        }
    }
    // MARK: - Data Functions
    func loadData() {
        
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
        return AppManger.shared.moviesData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as MoviesTableViewCell
        let yearString = String(AppManger.shared.moviesData[indexPath.row].movieYear)
        cell.textLabel?.text = AppManger.shared.moviesData[indexPath.row].movieTitle
        cell.detailTextLabel?.text = yearString
        cell.imageView?.image = AppManger.shared.moviesData[indexPath.row].movieImage
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
        let movie = AppManger.shared.moviesData[indexPath.row]
        let storyboard = UIStoryboard(name: "DetailsSB", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.middleware.movie = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
