//
//  PopularMoviesTableViewCell.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import UIKit
import Kingfisher

class PopularMoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    
    @IBOutlet weak var lblReleaseDate: UILabel!
    
    @IBOutlet weak var lblGenres: UILabel!
    
    @IBOutlet weak var lblScore: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgMovie.kf.cancelDownloadTask()
        self.imgMovie.image = nil
    }
    static func identifier() -> String{
           return "PopularMoviesTableViewCell"
       }
    func configureCell(data : PopularMovieData){
        if let movieImage = data.posterPath{
            self.imgMovie.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  movieImage ), placeholder: UIImage.init(named: "movieDBLogo")) { (result) in
                self.layoutIfNeeded()
            }
        }
        if let ids = data.genreIDS {
            self.lblGenres.text = GenreDataHandler.shared.getGenreString(ids: ids, genre : .Movie)
        }
        if let title = data.title {
            self.lblMovieTitle.text = title
        }
        if let releaseDate = data.releaseDate {
            self.lblReleaseDate.text = releaseDate.dateFormatted()
        }
        if let rate = data.voteAverage {
            self.lblScore.text = String(format: "%.1f", rate) + "/10"
        }

    }
    
       
}
