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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func initTableView() {
            
            let nib = UINib(nibName: PopularMoviesTableViewCell.identifier(), bundle: nil)
            self.tblMain.register(nib, forCellReuseIdentifier: NewsTableViewCell.identifier())
            self.tblMain.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1.0))
            self.tblMain.delegate = self
            self.tblMain.dataSource = self
            self.tblMain.rowHeight = UITableView.automaticDimension
            self.tblMain.estimatedRowHeight = 150
            self.tblMain.alwaysBounceVertical = false
        }
       

    func loadData(page : Int = 1){
        
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
        cell.configureCell(item: self.newsItems[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == self.popularMovies.count - 3 && self.popularMovies.count % self.pageSize == 0{
            self.loadData(page:  self.popularMovies.count / self.pageSize)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        
        movieDetailVC.movieId = self.popularMovies[indexPath.row].id
       
        self.navigationController?.pushViewController(movieDetailVC , animated: true)
        
    }
    
}
