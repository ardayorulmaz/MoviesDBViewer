//
//  SearchViewController.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var tblMain: UITableView!
    @IBOutlet weak var txtfldSearchField: UITextField!
    
    var textTypingDispatch :DispatchWorkItem?
    var lastkeyword : String?
    var pageSize = 20
    var results : [Result] = []
    
//    var searchResults : [MultiSearchResult(T)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        // Do any additional setup after loading the view.
    }
    func initTableView() {
            
            let nib = UINib(nibName: SearchResultsTableViewCell.identifier(), bundle: nil)
            self.tblMain.register(nib, forCellReuseIdentifier: SearchResultsTableViewCell.identifier())
            self.tblMain.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1.0))
            self.tblMain.delegate = self
            self.tblMain.dataSource = self
            self.tblMain.rowHeight = UITableView.automaticDimension
            self.tblMain.estimatedRowHeight = 150
            self.tblMain.alwaysBounceVertical = false
        }
    
    func searchKeyword(word : String, page : Int = 1){
        if page == 1 {
            self.results = []
        }
        SearchAPICalls.multiSearch(keyword: word, page: page) { (response) in
            self.lastkeyword = word
            guard let data = response?.results else{
                return
            }
            self.results.append(contentsOf: data)
            self.tblMain.reloadData()
            print(data.count)
        } failure: { (error) in
            print(error.debugDescription)
        }

        
    }

    @IBAction func textTyped(_ sender: Any) {
        
        if let textTyping = self.textTypingDispatch {
            textTyping.cancel()
        }
        if let text =  self.txtfldSearchField.text, text.count >= 2{
            self.textTypingDispatch = DispatchWorkItem {
                print(text)
                self.searchKeyword(word : text)
            }
            if let textTyping = self.textTypingDispatch {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: textTyping)
            }
        }
    }
    

}
extension SearchViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier(), for: indexPath) as! SearchResultsTableViewCell
        if self.results.count > 0{
        cell.configureCell(data: self.results[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let keyword = self.lastkeyword else {
            return
        }
        if indexPath.row == self.results.count - 3 && self.results.count % self.pageSize == 0{
            self.searchKeyword(word : keyword, page:  (self.results.count / self.pageSize)+1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let movieDetailVC = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        
     //   movieDetailVC.movieId = self.popularMovies[indexPath.row].id
       
        self.navigationController?.pushViewController(movieDetailVC , animated: true)
        
    }
    
}
