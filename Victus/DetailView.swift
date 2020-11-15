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
        VStack {
            Text(predictedFood).fontWeight(.semibold).font(.largeTitle).padding([.top, .trailing], 8)
                .padding(.bottom, 8)
            
            HStack (alignment: .center, spacing: 10) {
                VStack{
                    Text(observed.food.calories + " kcal").fontWeight(.medium)
                    Text("Calories")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, 4.0)
                .background(Color.gray)
                .cornerRadius(4)
                
                
                
                VStack{
                    Text(observed.food.fat + " g").fontWeight(.medium)
                    Text("Fat")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, 4.0)
                .background(Color.gray)
                .cornerRadius(4)
                
                
                
                VStack{
                    Text(observed.food.protien + " g").fontWeight(.medium)
                    Text("Calories")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, 4.0)
                .background(Color.gray)
                .cornerRadius(4)
                
                
            }
            .padding(.bottom, 8)
            
            HStack (alignment: .center, spacing: 10) {
                VStack{
                    Text(observed.food.protien + " g").fontWeight(.medium)
                    Text("Carbohydrates")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, 4.0)
                .background(Color.gray)
                .cornerRadius(4)
                
                
                
                VStack{
                    Text(observed.food.fiber + " g").fontWeight(.medium)
                    Text("Fiber")
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.all, 4.0)
                .background(Color.gray)
                .cornerRadius(4)
                
                
            }
            .padding(.bottom, 8)
            
            
            /* Immunity Friendly */
            if !observed.food.immunity.isEmpty {
                Button(action: {
                    let url: NSURL = URL(string: observed.food.immunityURL)! as NSURL
                    UIApplication.shared.open(url as URL)
                }) {
                    
                    HStack {
                        Image(systemName: "link")
                            .font(.system(size: 20))
                        VStack (alignment: .leading) {
                            Text("Immunity Boosting Recipe")
                                .font(.headline)
                            Text(observed.food.immunity)
                        }
                        Spacer()
                    }
                    .padding(.leading, 8.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.bottom, 8.0)
            }
            
            /* Keto Friendly */
            if !observed.food.keto.isEmpty {
                Button(action: {
                    let url: NSURL = URL(string: observed.food.ketoURL)! as NSURL
                    UIApplication.shared.open(url as URL)
                }) {
                    
                    HStack {
                        Image(systemName: "link")
                            .font(.system(size: 20))
                        VStack (alignment: .leading) {
                            Text("Keto Friendly Recipe")
                                .font(.headline)
                            Text(observed.food.keto)
                        }
                        Spacer()
                    }
                    .padding(.leading, 8.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding(.bottom, 8.0)
            }
            
            /* Vegan Friendly */
            if !observed.food.vegan.isEmpty {
                Button(action: {
                    let url: NSURL = URL(string: observed.food.veganURL)! as NSURL
                    UIApplication.shared.open(url as URL)
                }) {
                    
                    HStack {
                        Image(systemName: "link")
                            .font(.system(size: 20))
                        VStack (alignment: .leading) {
                            Text("Vegan Friendly Recipe")
                                .font(.headline)
                            Text(observed.food.vegan)
                        }
                        Spacer()
                    }
                    .padding(.leading, 8.0)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
        }
        .padding([.leading, .bottom, .trailing], 16.0)
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
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
    }
    
}

class Observer : ObservableObject{
    @Published var food: FoodData
    
    init() {
        food = FoodData()
    }
    
    func getFood(name: String){
        /* Nutritional Information */
        var info = "https://api.edamam.com/api/food-database/v2/parser?nutrition-type=logging&ingr=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=55f196fc&app_key=ce1127697090b419366d902188f2f303"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            let calories:Double = objectJSON["hints"][0]["food"]["nutrients"]["ENERC_KCAL"].doubleValue
            self.food.calories = String(format: "%.2f", calories)
            let protien = objectJSON["hints"][0]["food"]["nutrients"]["PROCNT"].doubleValue
            self.food.protien = String(format: "%.2f", protien)
            let fat = objectJSON["hints"][0]["food"]["nutrients"]["FAT"].doubleValue
            self.food.fat = String(format: "%.2f", fat)
            let carbs = objectJSON["hints"][0]["food"]["nutrients"]["CHOCDF"].doubleValue
            self.food.carbs = String(format: "%.2f", carbs)
            let fiber = objectJSON["hints"][0]["food"]["nutrients"]["FIBTG"].doubleValue
            self.food.fiber = String(format: "%.2f", fiber)
        }
        
        /* Immunity Boosting */
        info = "https://api.edamam.com/search?q=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=18e2d69f&app_key=0d216f642c316f37fb7828ccae4596e2&health=immuno-supportive"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.immunity = objectJSON["hits"][0]["recipe"]["label"].stringValue
            self.food.immunityURL = objectJSON["hits"][0]["recipe"]["url"].stringValue
        }
        
        /* Keto Friendly */
        info = "https://api.edamam.com/search?q=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=18e2d69f&app_key=0d216f642c316f37fb7828ccae4596e2&health=keto-friendly"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.keto = objectJSON["hits"][0]["recipe"]["label"].stringValue
            self.food.ketoURL = objectJSON["hits"][0]["recipe"]["url"].stringValue
        }
        
        /* Vegan Friendly */
        info = "https://api.edamam.com/search?q=" + name.replacingOccurrences(of: " ", with: "-") + "&app_id=18e2d69f&app_key=0d216f642c316f37fb7828ccae4596e2&health=vegan"
        AF.request(info).responseJSON { response in
            let objectJSON: JSON = JSON(response.data!)
            self.food.vegan = objectJSON["hits"][0]["recipe"]["label"].stringValue
            self.food.veganURL = objectJSON["hits"][0]["recipe"]["url"].stringValue
        }
    }
    
}
