//
//  DetailView.swift
//  Victus
//
//  Created by Sudarshan Sreeram on 15/11/2020.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct DetailView: View {
    var predictedFood: String
    @Binding var showSheet: Bool
    @Binding var imageSelected: Bool
    @Binding var activeSheet: ActiveSheet
    @ObservedObject var observed = Observer()
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(predictedFood).fontWeight(.semibold).font(.largeTitle).padding([.top, .bottom, .trailing], 8)
            Divider()
            Text(observed.food.calories)
            Text(observed.food.fat)
            Text(observed.food.protien)
            Text(observed.food.carbs)
            Text(observed.food.fiber)
            Text("Immunity Boosting: " + (observed.food.immunity.isEmpty ? "None" : observed.food.immunity))
            Text("Keto Friendly: " + (observed.food.keto.isEmpty ? "None" : observed.food.keto))
            Text("Vegan Friendly: " + (observed.food.vegan.isEmpty ? "None" : observed.food.vegan))
        }
        .padding(.all, 8.0)
        .onAppear { observed.getFood(name: predictedFood) }
        
        Spacer ()
        Button(action: {
            showSheet = false
            activeSheet = .photo
            imageSelected = false
        }) {
            HStack {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 20))
                
                Text("Dismiss")
                    .font(.headline)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(16)
            .padding(.horizontal, 16)
        }
    }
    
}

class Observer : ObservableObject{
    @Published var food: FoodData

    init() {
        food = FoodData(calories: "", protien: "", fat: "", carbs: "", fiber: "", immunity: "", vegan: "", keto: "")
    }
    
    func getFood(name: String){
        /* Nutritional Information */
        var info = "https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=55f196fc&app_key=ce1127697090b419366d902188f2f303"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.calories = "Calories: " + objectJSON["hints"][0]["food"]["nutrients"]["ENERC_KCAL"].stringValue + "\n"
            self.food.protien = "Protein: " + objectJSON["hints"][0]["food"]["nutrients"]["PROCNT"].stringValue + "\n"
            self.food.fat = "Fat: " + objectJSON["hints"][0]["food"]["nutrients"]["FAT"].stringValue + "\n"
            self.food.carbs = "Carbs: " + objectJSON["hints"][0]["food"]["nutrients"]["CHOCDF"].stringValue + "\n"
            self.food.fiber = "Fiber: " + objectJSON["hints"][0]["food"]["nutrients"]["FIBTG"].stringValue + "\n"
        }
        
        /* Immunity Boosting */
        info = "https://api.edamam.com/search?q=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=18e2d69f&app_key=0d216f642c316f37fb7828ccae4596e2&health=immuno-supportive"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.immunity = objectJSON["hits"][0]["recipe"]["label"].stringValue
        }
        
        /* Keto Friendly */
        info = "https://api.edamam.com/search?q=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=18e2d69f&app_key=0d216f642c316f37fb7828ccae4596e2&health=keto-friendly"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.keto = objectJSON["hits"][0]["recipe"]["label"].stringValue
        }
        
        /* Vegan Friendly */
        info = "https://api.edamam.com/search?q=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=18e2d69f&app_key=0d216f642c316f37fb7828ccae4596e2&health=vegan"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.vegan = objectJSON["hits"][0]["recipe"]["label"].stringValue
        }
    }
    
}
