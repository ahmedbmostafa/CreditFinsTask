//
//  MovieTableViewCell.swift
//  CreditFinsTask
//
//  Created by ahmed mostafa on 28/01/2022.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func populateWithViewModel(cellViewModel: MovieTableViewCellViewModel) {
        movieTitleLbl.text = cellViewModel.movieTitle
        let url = URL(string: cellViewModel.movieImgUrl )
        movieImg.kf.setImage(with: url)
    }
}
