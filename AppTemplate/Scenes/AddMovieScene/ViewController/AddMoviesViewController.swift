//
//  AddMoviesViewController.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import UIKit

class AddMoviesViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var movieTitleTF: UITextField!
    @IBOutlet weak var movieYearTF: UITextField!
    @IBOutlet weak var movieGenTF: UITextField!
    @IBOutlet weak var MovieRateTF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    // MARK: - Props
    var middleware = AddMoviesMiddleware()
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = 20
        gestureRecognizer()
        initView()
    }
    // MARK: - Main Functions
    func initView() {
        imageView.layer.cornerRadius = 20
        title = "Add New Movie"
    }
    func initViewModel() {
        
    }
    // MARK: - View Functions
    func gestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapp))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    @objc func tapp() {
        let actionSheet = UIAlertController(title: "Add Image", message: "Add Image From Gallery or Camera", preferredStyle: .actionSheet)
        let imageGallery = UIAlertAction(title: "Gallery", style: .default) { _ in
            self.presentGallery()
          }
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.presentCamera()
          }
        let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
              print("Cancel")
          }
        actionSheet.addAction(imageGallery)
        actionSheet.addAction(camera)
        actionSheet.addAction(cancelActionButton)
        self.present(actionSheet, animated: true)
    }
    // MARK: - Functions
    func presentGallery() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    func presentCamera() {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    // MARK: - IBActions
    @IBAction func addNewMovies(_ sender: UIButton) {
        let moviesTitle = movieTitleTF.text ?? ""
        let movieYearTF = movieYearTF.text ?? ""
        let movieGenTF = movieGenTF.text ?? ""
        let MovieRateTF = MovieRateTF.text ?? ""
        guard let imageView = imageView.image else { return }
        middleware.addNewMovies(moviesTitle: moviesTitle, movieYear: movieYearTF, movieImage: imageView, movieRating: MovieRateTF, movieGenre: movieGenTF)
        AppManger.shared.moviesData = middleware.moviesData
        self.navigationController?.popViewController(animated: true)
    }

}
extension AddMoviesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        imageView.image = image
    }
}
