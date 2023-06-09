//
//  weatherModel.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 21/05/2023.
//

import Foundation
struct WeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var conditionName: String {

        switch conditionId {
        case 200...232:
            return "cloud.boult"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 800...801:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
