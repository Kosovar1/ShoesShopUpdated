//
//  WeatherManager.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 19/05/2023.
//


import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
   func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
   func didFailWithError(error: Error)
}

struct WeatherManager {
   
   let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=9a0133ac12306290a0da37dfb293b28a&units=metric"
   
   var delegate: WeatherManagerDelegate?
   func fetchWeather(cityName: String ) {
       let urlString = "\(weatherUrl)&q=\(cityName)"
       performRequest(with: urlString)
       
       
   }
    func fetchWeather(latitude: CLLocationDegrees, longtitude: CLLocationDegrees ) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longtitude)"
        performRequest(with: urlString )
        
    }
   func performRequest(with urlString: String) {
       
       //create a URL
       if let url = URL(string: urlString) {
           //create URL seesion
           let session = URLSession(configuration: .default)
           //give session a task
           let task = session.dataTask(with: url) { (data, response, error) in
               if error != nil {
                   self.delegate?.didFailWithError(error: error!)
                   print(error!)
                   return
               }
               if let safeData = data {
                   if let weather = self.parseJSON(safeData) {
                       self.delegate?.didUpdateWeather(self, weather: weather)
                   }
               }
           }
               //start the task
               
               task.resume()
               
           }
       }
       func parseJSON(_ weatherData: Data) -> WeatherModel? {
           let decoder = JSONDecoder()
           do {
               let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
               let id = decodedData.weather[0].id
               
               let temp = decodedData.main.temp
               let name = decodedData.name
               let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
               return weather
//                print(weather.temperatureString)
           } catch {
               delegate?.didFailWithError(error: error)
               return nil
           }
       }
       
   }
