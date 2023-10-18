//
//  ApiManager.swift
//  Tehnical-TestiOS
//
//  Created by Dito on 18/10/23.
//

import Foundation
import Alamofire

class MealAPIManager {
    static let shared = MealAPIManager()
    
    private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    func searchMeals(query: String, completion: @escaping ([Meal]?, Error?) -> Void) {
        let searchURL = "\(baseURL)/search.php?s=\(query)"
        
        AF.request(searchURL).responseDecodable(of: MealsResponse.self) { response in
            if let error = response.error {
                completion(nil, error)
            } else if let meals = response.value?.meals {
                completion(meals, nil)
            } else {
                completion(nil, nil)
            }
        }
    }
}

struct MealsResponse: Decodable {
    let meals: [Meal]?
}
