//
//  ContentView.swift
//  Victus
//
//  Created by Sudarshan Sreeram on 15/11/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var imageSelected = false
    
    var body: some View {
        VStack {
            if self.imageSelected {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
            
            Spacer()
            
            Button(action: {
                self.isShowPhotoLibrary = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    
                    Text("Take Photo")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(16)
                .padding(.horizontal)
            }
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: self.$image, imageSelected: self.$imageSelected, sourceType: .camera)
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
