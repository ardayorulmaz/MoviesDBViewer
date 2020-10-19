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
    weak var delegate : SearchViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        
        // Do any additional setup after loading the view.
    }
    
    // Initializing table view 
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
     // Preferred to use single generic model for multi search results because hybrid model used here would only be usable for here and not for extended details that we require for detail pages and API's mostly optional resuts caused many other problems while casting a hybrid protocol based model.
    func searchKeyword(word : String, page : Int = 1){
        if page == 1 {
            self.results = []
            self.tblMain.showActivityIndicator()
        }
        SearchAPICalls.multiSearch(keyword: word, page: page) { (response) in
            self.lastkeyword = word
            
            guard let data = response?.results else{
                return
            }
            if page == 1 && data.count == 0{
                self.tblMain.restore()
                self.tblMain.setEmptyMessage("txtEmptySearchResults".localized)
                self.tblMain.reloadData()
                
            }else {
                self.results.append(contentsOf: data)
                self.tblMain.reloadData()
                
            }
            
           
        } failure: { (error) in
            print(error.debugDescription)
        }

        
    }
//Func for observing text field value  and auto search function with 2 second delay
    @IBAction func textTyped(_ sender: Any) {
        guard let delegate = self.delegate else {
            return
        }
        if let textTyping = self.textTypingDispatch {
            self.tblMain.restore()
            textTyping.cancel()
        }
        //Adding minimum two character limit for search
        if let text =  self.txtfldSearchField.text, text.count >= 2{
            
           // Delegate call for expanding the search view to show loading indicator
            delegate.expandView()
            self.textTypingDispatch = DispatchWorkItem {
               
                self.searchKeyword(word : text.replacingOccurrences(of: " ", with: "%20"))
            }
            //Delayed server call to prevent call flood.
            if let textTyping = self.textTypingDispatch {
                self.tblMain.showActivityIndicator()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: textTyping)
            }
        }else {
            //If text is deleted or les than two characters calling delegate to shrink search tableview
            delegate.collapseView()
            
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
        
        //Paginating results to ease data use
        guard let keyword = self.lastkeyword else {
            return
        }
        if indexPath.row == self.results.count - 3 && self.results.count % self.pageSize == 0{
            self.searchKeyword(word : keyword, page:  (self.results.count / self.pageSize)+1)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //search results to item detail function, didnt implement for tv shows because it required different detail data call and different sections for detail page.
        guard let delegate = self.delegate, self.results.count > 0
        else {
            return
        }
        delegate.resultSelected(id: self.results[indexPath.row].id, media: results[indexPath.row].mediaType)
    }
    
}
