//
//  CreditsCollectionViewCell.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import UIKit

class CreditsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblPerson: UILabel!
    @IBOutlet weak var lblPersonJob: UILabel!
    @IBOutlet weak var imgPerson: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func identifier()->String{
        
        return "CreditsCollectionViewCell"
    }
    func initCreditsWith(data : Crew){
        if let image = data.profilePath{
        self.imgPerson.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  image ), placeholder: UIImage.init(named: "movieDBLogo") )
        }
        else {
            self.imgPerson.image = UIImage.init(named: "movieDBLogo")
        }
        self.lblPerson.text = data.name ?? ""
        self.lblPersonJob.text = data.job ?? ""


    }
    func initCreditsWith(data : Cast
    ){
        if let image = data.profilePath{
        self.imgPerson.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  image ), placeholder: UIImage.init(named: "movieDBLogo") )
        }
        else {
            self.imgPerson.image = UIImage.init(named: "movieDBLogo")
        }
        self.lblPerson.text = data.name ?? ""
        self.lblPersonJob.text = data.character ?? ""


    }
    
    func initCreditsWith(data : CreditsOf){
        if let image = data.posterPath{
        self.imgPerson.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  image ), placeholder: UIImage.init(named: "movieDBLogo") )
        }
        else {
            self.imgPerson.image = UIImage.init(named: "movieDBLogo")
        }
        self.lblPerson.text = data.character ?? ""
        self.lblPersonJob.text = data.job ?? ""


    }
}
