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
    
    
//    var searchResults : [MultiSearchResult(T)] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    func searchKeyword(word : String){
        
        
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
