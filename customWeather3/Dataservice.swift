//
//  Dataservice.swift
//  customWeather3
//
//  Created by Hao on 9/27/17.
//  Copyright © 2017 Hao. All rights reserved.
//

import Foundation
let NotificationKey = Notification.Name.init("key")
class DataServices {
    static let shared : DataServices = DataServices()
    let urlString = "https://api.apixu.com/v1/forecast.json?key=83a7408e23ec4694a0e122846172709&q=Hanoi&days=7"
    private var _weather: Weather?
    var weather: Weather? {
        get {
            if _weather == nil {
                requestData()
            }
            return _weather
        }
        set {
            _weather = newValue
        }
    }
    var forecastday : [ForecastDay] = []
    private var _hours: [Hour]?
    var hours: [Hour] {
        get {
            if _hours == nil {
                createArrayHourInDays()
            }
            return _hours ?? []
        }
        set {
            _hours = newValue
        }
    }
    func createArrayHourInDays() {
        if let timeCurrent = weather?.current.last_updated_epoch {
            _hours = weather?.forecast.forecastday[0].hour.filter {
                $0.time_epoch > timeCurrent
            }
        }
        for i in 0...23 {
            _hours?.append((weather?.forecast.forecastday[1].hour[i])!)
        }

    }
    

    func requestData() {
        guard let url = URL(string: urlString) else { return }
        let requestURL = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil else { return }
            guard data != nil else { return }
            DispatchQueue.main.async {
                self._weather = try? JSONDecoder().decode(Weather.self, from: data!)
                NotificationCenter.default.post(name: NotificationKey, object: nil)
            }
        }
        task.resume()
        
    }
}
