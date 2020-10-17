//
//  PopularMoviesTableViewCell.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    static func identifier() -> String{
           return "PopularMoviesTableViewCell"
       }
    func configureCell(data : MovieData){
        
        
    }
    
       
}
