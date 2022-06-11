//
//  MoviesTableViewCell.swift
//  AppTemplate
//
//  Created by Ahmad Ashraf on 11/06/2022.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(movies: Movies) {
        let yearString = movies.moviesYear
        let imageBase64 = movies.movieImage
        let dataDecoded : Data = Data(base64Encoded: imageBase64!, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        imageView!.image = decodedimage
        textLabel?.text = movies.moviesTitle
        detailTextLabel?.text = yearString
    }
    
}
