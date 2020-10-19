//
//  VideoReusableViewCollectionViewCell.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//
import youtube_ios_player_helper
import UIKit

class VideoReusableViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var vwYTVideo: YTPlayerView!
    var videoKey : String?
    static func identifier()->String{
        return "VideoReusableViewCollectionViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setupPlayer(key : String){
        self.vwYTVideo.load(withVideoId: key, playerVars: ["playsinline": "1"])
        

    }
}
