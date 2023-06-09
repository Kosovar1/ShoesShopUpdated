//
//  Recipe.swift
//  ShoesShop
//
//  Created by Kosovar Latifi on 10/05/2023.
//

import Foundation

struct Recipe {
    let id: Int
    var image: String
    var name: String
    var timeToPrepare: String?
    var stepsToPrepare: String?
    var isFavorite: Bool = false
    var isRated: Bool = false
    var rateValue: Int = 0
}
