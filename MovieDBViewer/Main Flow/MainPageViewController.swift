//
//  MainPageViewController.swift
//  MovieDBViewer
//
//  Created by ArdaY on 17/10/2020.
//

import UIKit
// Using a delegate to scale search views height when searching starts
protocol SearchViewDelegate : class {
    func expandView()
    func collapseView()
    func resultSelected(id : Int, media : MediaType)
}

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var vwSearch: UIView!
    @IBOutlet weak var tblMain: UITableView!
    
    @IBOutlet weak var cnstSearchViewHeight: NSLayoutConstraint!
    var popularMovies : [PopularMovieData
    ] = []
    var pageSize : Int = 20
    var searchViewMaxHeight : CGFloat = 250.0
    var searchViewMinHeight : CGFloat = 60.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        self.loadData(page: 1)
        self.setupSearchView()
        self.cnstSearchViewHeight.constant = self.searchViewMinHeight
        // Do any additional setup after loading the view.
    }
    
    //Drtup for search view controller as child view controller
    func setupSearchView(){
        
        let searchVC = SearchViewController(nibName: "SearchViewController", bundle: nil)
        self.addChild(searchVC)
        self.vwSearch.addSubview(searchVC.view)
        searchVC.view.frame = self.vwSearch.bounds
        searchVC.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        searchVC.delegate = self
        searchVC.didMove(toParent: self)
        
    }
    
    //Initializing tableview and its reusable cells
    func initTableView() {
        
        let nib = UINib(nibName: PopularMoviesTableViewCell.identifier(), bundle: nil)
        self.tblMain.register(nib, forCellReuseIdentifier: PopularMoviesTableViewCell.identifier())
        self.tblMain.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 100.0))
        self.tblMain.delegate = self
        self.tblMain.dataSource = self
        self.tblMain.rowHeight = 210
        self.tblMain.estimatedRowHeight = 210
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
extension MainPageViewController : SearchViewDelegate {
    func resultSelected(id: Int, media : MediaType) {
        switch  media {
        case .movie:
            let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
            
            movieDetailVC.movieID = id
            movieDetailVC.modalPresentationStyle = .overFullScreen
            self.present(movieDetailVC , animated: true)
        case .person:
            let personDetailVC = PersonDetailViewController(nibName: "PersonDetailViewController", bundle: nil)
            personDetailVC.personId = id
            personDetailVC.modalPresentationStyle = .overFullScreen
            self.present(personDetailVC, animated: true, completion: nil)
        case .tv:
            print("Not Implemented")
        }
       
    }
    
    func expandView() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseInOut]) {
            self.cnstSearchViewHeight.constant = self.searchViewMaxHeight
        }
    }
    
    func collapseView() {
        UIView.animate(withDuration: 0.5, delay: 0.1, options: [.curveEaseInOut]) {
            self.cnstSearchViewHeight.constant = self.searchViewMinHeight
        }
    }
    
    
    
}
