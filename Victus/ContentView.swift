//
//  ContentView.swift
//  Victus
//
//  Created by Sudarshan Sreeram on 15/11/2020.
//

import SwiftUI
import CoreML

enum ActiveSheet {
    case photo, detail
}

struct ContentView: View {
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var imageSelected = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var showSheet = false
    @State private var activeSheet: ActiveSheet = .photo
    @State private var predictedFood = ""
    
    var body: some View {
        VStack {
            Text("Victus").fontWeight(.semibold).font(.largeTitle)
            if self.imageSelected {
                Image(uiImage: self.image)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity)
            } else {
                Image("placeholder")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom, 32)
                    .padding(.horizontal, 16.0)
                Text("Victus uses machine learning to identify the type of food and extracts nutritional information through API calls to Edamam. To get started, click on 'Take Photo'")
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Button(action: {
                self.isShowPhotoLibrary = true
                self.showSheet = true
            }) {
                HStack {
                    Image(systemName: "photo")
                        .font(.system(size: 20))
                    
                    Text("Take Photo")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding([.top, .leading, .trailing], 16)
                .padding(.bottom, 8)
            }
            
            Button(action: {
                /* Resize and crop image to appropriate size */
                image = cropImage(image: resizeImage(image: image, targetSize: CGSize(width: 299, height: 299)))
                /* Call prediction routine on modified image */
                predictFood()
                activeSheet = .detail
            }) {
                HStack {
                    Image(systemName: "wand.and.rays")
                        .font(.system(size: 20))
                    
                    Text("Identify Food")
                        .font(.headline)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .background(self.imageSelected ? Color.accentColor : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.horizontal, 16)
            }
            .disabled(!self.imageSelected)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")){ self.imageSelected = false })
        }
        .sheet(isPresented: $showSheet) {
            if activeSheet == .photo {
                ImagePicker(selectedImage: self.$image, imageSelected: self.$imageSelected, sourceType: .camera)
            } else {
                DetailView(predictedFood: predictedFood, showSheet: self.$showSheet, imageSelected: self.$imageSelected, activeSheet: self.$activeSheet)
            }
        }
    }
    
    func predictFood() {
        let model: FoodClassifier = {
            do {
                let config = MLModelConfiguration()
                return try FoodClassifier(configuration: config)
            } catch {
                print(error)
                fatalError("Couldn't create FoodClassifier")
            }
        }()
        do {
            // Force un-wrapping is bad. Fix this later.
            let prediction = try model.prediction(image: buffer(from: image)!)
            predictedFood = prediction.classLabel.replacingOccurrences(of: "_", with: " ").capitalized
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem identifying the food item"
        }
        self.showSheet = true
    }
    
    /* The follwing code block was 'borrowed' from the following stack-overflow post:
     * https://stackoverflow.com/questions/44462087/how-to-convert-a-uiimage-to-a-cvpixelbuffer */
    func buffer(from image: UIImage) -> CVPixelBuffer? {
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return nil
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)
        
        context?.translateBy(x: 0, y: image.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    /* The follwing code block was 'borrowed' from the following stack-overflow post:
     * https://stackoverflow.com/questions/60617982/swift-cropping-an-image-to-remove-bottom-part */
    func cropImage(image: UIImage) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 299, height: 299)
        
        let cgImage = image.cgImage!
        
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
    
    /* The follwing code block was 'borrowed' from the following stack-overflow post:
     * https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift */
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio < heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
