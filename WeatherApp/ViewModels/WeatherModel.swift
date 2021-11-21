//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Natthaporn Wimonanupong on 17/11/2564 BE.
//

import Foundation

class WeatherModel: ObservableObject{
    
    //@ObservedObject var model = WeatherModel()
    @Published var weather: WeatherResponse?
    var country = ""
    var url = URL(string:"")
    
    
    init(){
        // Make the request to the API
        let session = URLSession.shared
        
        url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=13.736717&lon=100.523186&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        
        let task = session.dataTask(with: self.url!) { data, response, error in
            // Check for error and data
            if data != nil && error == nil {
                
                // Pares the response into Weather obj
                let decoder = JSONDecoder()
                
                do{
                   var weatherResponse = try decoder.decode(WeatherResponse.self, from: data!)
                    
                    // Add UUID to the hourly weather obj
                    for i in 0..<weatherResponse.hourly.count{
                        weatherResponse.hourly[i].id = UUID()
                    }
                    
//                    for i in 0..<weatherResponse.daily.count {
//                        weatherResponse.daily[i].id = UUID()
//                    }
                    
                    // update the weather property with the prase
                    DispatchQueue.main.async {
                        
                        // Set the waether property with the parsed obj
                        self.weather = weatherResponse
                        print(weatherResponse.daily[0].temp.day)
                    }
                }
                catch{ }
            }
        }
        task.resume()
    }
    
    func set(country: String){
        self.country = country

        if country == "Thailand" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=13.736717&lon=100.523186&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Brunei Darussalam" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=4.5242486&lon=114.7196266&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
            print("Brunei Darussalam")
        }
        else if country == "Cambodia" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=11.562108&lon=104.888535&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
            print("Cambodia")
        }
        else if country == "Laos" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=17.974855&lon=102.630867&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Malaysia" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=3.140853&lon=101.693207&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Myanmar" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=16.871311&lon=96.199379&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Philippines" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=11.6978352&lon=122.6217542&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Singapore" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=1.290270&lon=103.851959&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Vietnam" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=10.762622&lon=106.660172&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }
        else if country == "Indonesia" {
            url = URL(string:"https://api.openweathermap.org/data/2.5/onecall?lat=-6.200000&lon=106.816666&exclude=alerts&appid=f3e89f182d7a5bf1c365e70e896850b9&units=metric")
        }

        // Make the request to the API
        let session = URLSession.shared

        let task = session.dataTask(with: self.url!) { data, response, error in
        // Check for error and data
            if data != nil && error == nil {

                // Pares the response into Weather obj
                let decoder = JSONDecoder()

                    do{
                        var weatherResponse = try decoder.decode(WeatherResponse.self, from: data!)

                        // Add UUID to the hourly weather obj
                        for i in 0..<weatherResponse.hourly.count{
                            weatherResponse.hourly[i].id = UUID()
                        }
                        // update the weather property with the prase
                        DispatchQueue.main.async {

                            // Set the waether property with the parsed obj
                            self.weather = weatherResponse
                            //print(weatherResponse)
                        }
                    }
                    catch{ }
            }
        }
        task.resume()
    }
}
