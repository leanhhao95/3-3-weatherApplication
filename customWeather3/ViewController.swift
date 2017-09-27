//
//  ViewController.swift
//  customWeather3
//
//  Created by Hao on 9/27/17.
//  Copyright © 2017 Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate , UICollectionViewDataSource {
    
  
    @IBOutlet weak var myCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollection.delegate = self
        myCollection.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NotificationKey, object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func updateData()  {
        myCollection.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = DataServices.shared.weather?.forecast.forecastday[0].hour.count else { return 0  }
        return count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCC
        
        if indexPath.row == 0 {
            cell.dateLabel.text = "Now"
            guard let temp = DataServices.shared.weather?.current.temp_c else { fatalError("Error") }
            cell.timeLabel.text? = "\(temp)"
            guard let  icon = DataServices.shared.weather?.current.condition.icon else { fatalError("Error") }
            cell.iconImage.downloadedFrom(urlString: "https:\(icon)")
        }
        else {
            cell.dateLabel.text = DataServices.shared.hours[indexPath.row - 1].time_epoch.gethour()
            let temp = DataServices.shared.hours[indexPath.row - 1].temp_c
            cell.timeLabel.text = "\(temp)"
            let icon =  DataServices.shared.hours[indexPath.row - 1].condition.icon
            cell.iconImage.downloadedFrom(urlString: "https:\(icon)")
            
        }
        
        return cell
        
        
    }
}
