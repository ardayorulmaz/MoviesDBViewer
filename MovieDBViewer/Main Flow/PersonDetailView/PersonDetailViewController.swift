//
//  PersonDetailViewController.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var imgPersonImage: UIImageView!
    
    
    @IBOutlet weak var lblPersonName: UILabel!
    
    @IBOutlet weak var lblBiography: UILabel!
    
    @IBOutlet weak var lblExtraData: UILabel!
    
    
    @IBOutlet weak var cltnMain: UICollectionView!
    var personId : Int?
    
    var cellSize : CGSize = CGSize.init(width: 120, height: 180)
    var creditsCount : Int = 0
    var credits : InCredits?
    var cast : [CreditsOf] = []
    var crew : [CreditsOf] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.configureCollectionView()
        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        guard let id = self.personId else {
            return
        }
        
        PersonDetailAPICAlls.getDetailExtended(id: id) { (response) in
            
            guard let data = response else {
                return
            }
            
            
            self.initValues(data: data)
        } failure: {
            (error) in
            print(error.debugDescription)
        }
        
        
    }
    func initValues(data : PersonDetail){
        //Preferring poster path over backdrop path because it shows less vertical empty space
        if let personImage = data.profilePath{
            self.imgPersonImage.kf.setImage(with: URL(string: ConfigurationDataHandler.shared.imageBaseURL() +  personImage ), placeholder: UIImage.init(named: "movieDBLogo") )
        }
        if let name = data.name {
            self.lblPersonName.text = title
        }
     
        if let bio = data.biography {
            self.lblBiography.text = bio
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

extension PersonDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource  {
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
        
        
        
    }
    
    
    
    
}


extension PersonDetailViewController: UICollectionViewDelegateFlowLayout  {
    
    
    
    
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

