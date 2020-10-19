//
//  TableViewExtensions.swift
//  MovieDBViewer
//
//  Created by ArdaY on 19/10/2020.
//
import UIKit
import Foundation
extension UITableView {
    
    //Tableview extension for showing empty tableview status and making an activity indicator
func setEmptyMessage(_ message: String) {
       
       //Main view
       let messageView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height:self.bounds.size.height))
       messageView.backgroundColor = .clear
       messageView.sizeToFit()
       messageView.autoresizingMask = [.flexibleLeftMargin,  .flexibleRightMargin]
       
       
       //Image view for empty message
       let messageImage = UIImageView.init(image: UIImage.init(named: "search"))
    messageImage.tintColor = .darkGray
       messageImage.frame = CGRect.init(x: (self.bounds.size.width/2)-25, y: 100, width: 50, height: 50)
       messageImage.autoresizingMask = [.flexibleLeftMargin,  .flexibleRightMargin]
       messageView.addSubview(messageImage)
       
       //Message label view
       
       let rect = CGRect(origin: CGPoint(x: 20, y :20), size: CGSize(width: self.bounds.size.width-40, height: 80))
       let messageLabel = UILabel(frame: rect)
       
       messageLabel.text = message
       messageLabel.textColor = .darkGray
       messageLabel.numberOfLines = 0;
       messageLabel.textAlignment = .center;
       messageLabel.font = UIFont.systemFont(ofSize: 16)
       messageLabel.autoresizingMask = [.flexibleLeftMargin,  .flexibleRightMargin]
       
       
       messageView.addSubview(messageLabel)
       
       
       self.backgroundView = messageView;
       self.separatorStyle = .none;
   }
    // Function to removebackground views from tableview and restore original status
    func restore(){
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
// To show loading indicator while a server call is ongoing 
    func showActivityIndicator(){
        var indicator = UIActivityIndicatorView()
        let rect = CGRect(origin: CGPoint(x: 20, y :80), size: CGSize(width: self.bounds.size.width-40, height: 80))
        indicator.frame = rect
        indicator.hidesWhenStopped = true
        indicator.style = .whiteLarge
        self.backgroundView = (indicator)
        indicator.startAnimating()
        
    }
}
