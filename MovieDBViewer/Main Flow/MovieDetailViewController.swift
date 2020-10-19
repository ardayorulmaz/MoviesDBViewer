//
//  MovieDetailViewController.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieID : Int?
    @IBOutlet weak var vwMovieImage: UIView!
    
    @IBOutlet weak var imgMovieImage: UIImageView!
    
    @IBOutlet weak var vwMovieTitle: UIView!
    
    @IBOutlet weak var lblMovieTItle: UILabel!
    
    @IBOutlet weak var lblScore: UILabel!
    
    @IBOutlet weak var lblVotes: UILabel!
    
    
    @IBOutlet weak var lblSummary: UILabel!
    
    @IBOutlet weak var lblExtraInfo: UILabel!
    
    @IBOutlet weak var cltnMain: UICollectionView!
    
    
    @IBOutlet weak var vwVideoContainer: VideoReusableView!
    
    var cellSize : CGSize = CGSize.init(width: 120, height: 180)
    var creditsCount : Int = 0
    var credits : Credits?
    var cast : [Cast] = []
    var crew : [Crew] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.configureCollectionView()
        // Do any additional setup after loading the view.
    }
    //Main func to load data from api
    
    func loadData(){
        guard let id = self.movieID else {
            return
        }
        
        MovieAPICalls.getDetailExtended(id: id) { (response) in
            guard let data = response else {
                return
            }
            
            
            self.initValues(data: data)
        } failure: {
            (error) in
            print(error.debugDescription)
        }
        
        
    }
    func initValues(data : MovieDetailExtended){
        //Preferring poster path over backdrop path because it shows less vertical empty space
        if let movieImage = data.posterPath{
            self.imgMovieImage.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  movieImage ), placeholder: UIImage.init(named: "movieDBLogo") )
        }
        if let title = data.title {
            self.lblMovieTItle.text = title
        }
        if let score = data.voteAverage{
            self.lblScore.text = String(format:"%0.1f", score) + "/10"
        }else{
            self.lblScore.text = "-/10"
        }
        if let voteCount = data.voteCount{
            self.lblVotes.text = String(voteCount)
        }else {
            self.lblVotes.isHidden = true
        }
        if let overView = data.overview {
            self.lblSummary.text = overView
        }
        else {
            //            self.vwOververview.ishidden = true
        }
        if let credits = data.credits{
            var creditsCount : Int = 0
            self.credits = credits
            if let crew = credits.crew {
                self.crew = crew
                creditsCount += crew.count
            }
            if let cast = credits.cast {
                self.cast = cast
                creditsCount += cast.count
                
            }
            self.creditsCount = creditsCount
            self.cltnMain.reloadData()
        }
        
        if let videos = data.videos?.results {
            var keys : [String] = []
            for item in videos{
                if item.site == "YouTube", let youtubeKey = item.key{
                    keys.append(youtubeKey)
            }
                self.vwVideoContainer.videoArray = keys
                
            }  }
        else {
                self.vwVideoContainer.isHidden = true
            }
        
        
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func closePressed(_ sender: Any) {
        
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func configureCollectionView() {
        
        
        cltnMain.dataSource = self
        cltnMain.delegate = self
        self.cltnMain.register(UINib(nibName: CreditsCollectionViewCell.identifier(), bundle:nil),
                               forCellWithReuseIdentifier: CreditsCollectionViewCell.identifier())
        cltnMain.backgroundColor = UIColor.clear
        
    }
    
    
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return self.creditsCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard  self.creditsCount > 0 else {
            return UICollectionViewCell()
        }
        if indexPath.row >= self.cast.count, self.crew.count > 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCollectionViewCell", for: indexPath) as! CreditsCollectionViewCell
            cell.initCreditsWith(data: self.crew[indexPath.row-self.cast.count] )
            return cell
        } else if indexPath.row < self.cast.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CreditsCollectionViewCell", for: indexPath) as! CreditsCollectionViewCell
            cell.initCreditsWith(data: self.cast[indexPath.row] )
            return cell
        }else{
            return UICollectionViewCell()
        }
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard  self.creditsCount > 0 else {
            return
        }
        
        let personDetailVC = PersonDetailViewController(nibName: "PersonDetailViewController", bundle: nil)
        if indexPath.row >= self.cast.count, self.crew.count > 0 {
            personDetailVC.personId = self.crew[indexPath.row-self.cast.count].id
        } else if indexPath.row < self.cast.count{
          
            personDetailVC.personId = self.cast[indexPath.row].id
        }
        
        personDetailVC.modalPresentationStyle = .overFullScreen
        self.present(personDetailVC , animated: true)
        
        
        
        
    }
    
    
    
    
}


extension MovieDetailViewController: UICollectionViewDelegateFlowLayout  {
    
    
    
    
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

