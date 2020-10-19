//
//  VideoReusableView.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import UIKit

class VideoReusableView: UIView, XibInstantiatable {
    var videoArray : [String]?{
       
        didSet{
            self.configureCollectionView()
            self.cltnMain.reloadData()
        }
    }
    var cellSize : CGSize = CGSize.init(width: 200, height: 112)
    @IBOutlet weak var cltnMain: UICollectionView!
    
    override init(frame: CGRect) {
             super.init(frame: frame)
             instantiate()
             
         }
         
         required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
             instantiate()
         }
         

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


func configureCollectionView() {
    
    
    self.cltnMain.dataSource = self
    self.cltnMain.delegate = self
    self.cltnMain.register(UINib(nibName: VideoReusableViewCollectionViewCell.identifier(), bundle:nil),
                           forCellWithReuseIdentifier: VideoReusableViewCollectionViewCell.identifier())
    cltnMain.backgroundColor = UIColor.clear
    
}


}

extension VideoReusableView: UICollectionViewDelegate, UICollectionViewDataSource  {
func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    guard let array = self.videoArray else {
return 0
}
    return array.count
    
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let array = self.videoArray else {
return UICollectionViewCell()
}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoReusableViewCollectionViewCell", for: indexPath) as! VideoReusableViewCollectionViewCell
        cell.setupPlayer(key : array[indexPath.row])
return cell
}





func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    
    
}




}


extension VideoReusableView: UICollectionViewDelegateFlowLayout  {




func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 5
}

func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return self.cellSize

}

}



