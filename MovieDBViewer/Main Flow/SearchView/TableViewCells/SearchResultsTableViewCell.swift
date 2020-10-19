//
//  SearchResultsTableViewCell.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var vwTextStack: UIStackView!
    @IBOutlet weak var lblExtraData: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCellPhoto: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgCellPhoto.image =  UIImage.init(named: "movieDBLogo")
        self.lblType.text = ""
        self.lblTitle.text = ""
        self.lblExtraData.text = ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func identifier() -> String{
           return "SearchResultsTableViewCell"
       }
    func configureCell(data : Result
    ){
        switch data.mediaType{
        case .tv:
            if let movieImage = data.posterPath{
                self.imgCellPhoto.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  movieImage ), placeholder: UIImage.init(named: "movieDBLogo") )
            }
            if let title = data.originalName {
                self.lblTitle.text = title
            } else {
                self.lblTitle.isHidden = true
            }
            if let releaseDate = data.firstAirDate {
                self.lblType.text = releaseDate.dateToYearFormatted() + " - TV Series"
            } else {
                self.lblType.isHidden
                 = true
            }
            if let ids = data.genreIDS {
                self.lblExtraData.text = GenreDataHandler.shared.getGenreString(ids: ids, genre : .TV)
            }
            else {
                self.lblExtraData.isHidden = true
            }
        case .movie:
            if let movieImage = data.posterPath{
                self.imgCellPhoto.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  movieImage ), placeholder: UIImage.init(named: "movieDBLogo") )
            }
            if let title = data.title {
                self.lblTitle.text = title
            } else {
                self.lblTitle.isHidden = true
            }
            if let releaseDate = data.releaseDate {
                self.lblType.text = releaseDate.dateToYearFormatted() + " - Movie"
            } else {
                self.lblType.isHidden
                 = true
            }
            if let ids = data.genreIDS {
                self.lblExtraData.text = GenreDataHandler.shared.getGenreString(ids: ids, genre : .Movie)
            }
            else {
                self.lblExtraData.isHidden = true
            }
        case .person:
            
            if let image = data.profilePath{
                self.imgCellPhoto.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  image ), placeholder: UIImage.init(named: "movieDBLogo") )
            }
            if let name = data.name {
                self.lblTitle.text = name
            } else {
                self.lblTitle.isHidden = true
            }
            if let gender = data.gender
            {
                self.lblType.text = gender == 1 ? "Actress" : "Actor"
            }
            if var knownWork = data.knownFor?[0].originalTitle{
                if let releaseDate = data.releaseDate {
                    knownWork += "("+releaseDate.dateToYearFormatted()+")"
                }
                self.lblExtraData.text = knownWork
            }
             else {
                self.lblExtraData.isHidden
                 = true
            }
          
      
        }
        
       
      
    }
    
    
}
