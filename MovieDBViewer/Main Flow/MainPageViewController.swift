//
//  MainPageViewController.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var tblMain: UITableView!
    
    var popularMovies : [PopularMovieData
    ] = []
    var pageSize : Int = 20
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.loadData(page: 1)
        self.setupSearchView()
        // Do any additional setup after loading the view.
    }
    
    
    func setupSearchView(){
        
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.addChild(searchVC)
        self.vwSearch.addSubview(searchVC.view)
        searchVC.view.frame = self.vwSearch.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        searchVC.didMove(toParent: self)
        
    }
    func initTableView() {
            
            let nib = UINib(nibName: PopularMoviesTableViewCell.identifier(), bundle: nil)
            self.tblMain.register(nib, forCellReuseIdentifier: PopularMoviesTableViewCell.identifier())
            self.tblMain.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1.0))
            self.tblMain.delegate = self
            self.tblMain.dataSource = self
            self.tblMain.rowHeight = UITableView.automaticDimension
            self.tblMain.estimatedRowHeight = 150
            self.tblMain.alwaysBounceVertical = false
        }
       

    func loadData(page : Int = 1){
        //Page parameter starts with 1 because of API’s preference
          
     
                
       //If we are calling first page, we are clearing our movie array..
                if page == 1 {
                    self.popularMovies = []
                }
          
                        MovieAPICalls.getPopular(page: page) { (data) in
                            
                            guard let responseData = data else {
                                return
                            }
         guard let movies = responseData.results, movies.count>0 else {
        return
        }
                            self.popularMovies.append(contentsOf: movies)
        self.tblMain.reloadData()
          

                        } failure: { (error) in
                            print("error while fetching \(page)")
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

}
extension MainPageViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.popularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PopularMoviesTableViewCell.identifier(), for: indexPath) as! PopularMoviesTableViewCell
        if self.popularMovies.count > 0{
        cell.configureCell(data: self.popularMovies[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.popularMovies.count - 3 && self.popularMovies.count % self.pageSize == 0{
            self.loadData(page:  (self.popularMovies.count / self.pageSize)+1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        
        movieDetailVC.movieID = self.popularMovies[indexPath.row].id
        movieDetailVC.modalPresentationStyle = .overFullScreen
        self.present(movieDetailVC , animated: true)
        
    }
    
}
