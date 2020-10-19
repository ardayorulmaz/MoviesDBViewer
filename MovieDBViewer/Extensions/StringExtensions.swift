//
//  StringExtensions.swift
//  MovieDBViewer
//
//  Created by ArdaY on 18/10/2020.
//

import Foundation
extension String {
    
    
    func dateFormatted()->String{
        let selfDateFormatter = DateFormatter()
        selfDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateToFormat = selfDateFormatter.date(from: self) else { return "" }
        let desiredDateFormatter = DateFormatter()
        desiredDateFormatter.dateFormat = "dd/MM/yyyy"
        return desiredDateFormatter.string(from: dateToFormat)
    }
    func dateToYearFormatted()->String{
        let selfDateFormatter = DateFormatter()
        selfDateFormatter.dateFormat = "yyyy-MM-dd"
        guard let dateToFormat = selfDateFormatter.date(from: self) else { return "" }
        let desiredDateFormatter = DateFormatter()
        desiredDateFormatter.dateFormat = "yyyy"
        return desiredDateFormatter.string(from: dateToFormat)
    }
}
