//
//  extension.swift
//  customWeather3
//
//  Created by Hao on 9/27/17.
//  Copyright © 2017 Hao. All rights reserved.
//

import Foundation
import UIKit
extension TimeInterval {
    func gethour() -> String {
        let hour = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        dateFormatter.locale = Locale(identifier: "EN" )
        return dateFormatter.string(from: hour )
    }
   
        func dayWeek() -> String {
            let getDay = Date(timeIntervalSince1970: self)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.locale = Locale(identifier: "EN" )
            return dateFormatter.string(from: getDay )
        
}
}
extension UIImageView {
    
    func downloadedFrom(urlString: String) {
        guard let url = URL(string : urlString) else {return}
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
}
}

