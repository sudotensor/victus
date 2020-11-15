//
//  FoodData.swift
//  Victus
//
//  Created by Sudarshan Sreeram on 15/11/2020.
//

import Foundation

struct FoodData {
    /* Nutritional Information */
    public var calories: String
    public var protien: String
    public var fat: String
    public var carbs: String
    public var fiber: String
    
    /* Better Alternatives */
    public var immunity: String
    public var vegan: String
    public var keto: String
    
    /* Links To Recipes */
    public var immunityURL: String
    public var veganURL: String
    public var ketoURL: String
    
    init() {
        calories = ""
        protien = ""
        fat = ""
        carbs = ""
        fiber = ""
        
        immunity = ""
        immunityURL = ""
        
        vegan = ""
        veganURL = ""
        
        keto = ""
        ketoURL = ""
    }
}
