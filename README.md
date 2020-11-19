## Victus

> Latin translation: '_that which sustains life_'

Victus is an iOS application that provides nutritional information of food items, coupled with recipe suggestions for vegan, sustainable, and immunity-boosting alternatives. The app was developed in collaboration with [Archit Soni](https://github.com/archit-soni) and [Siddhant Sharma](https://github.com/sidsharma3) as a submission for Oxford Hack 2020.

https://youtu.be/A8DvlulOE4U

### Inspiration

Eating habits have always had an impact not only on our immunity but also on our environment. Lockdowns have only made these habits worse. To this end, we set to develop Victus - an iOS application that provides the nutritional information of food items while informing the user of sustainable and immunity-boosting alternatives. 

Changing eating habits is crucial for sustainability since, according to an Oxford University [study](https://www.independent.co.uk/life-style/health-and-families/veganism-environmental-impact-planet-reduced-plant-based-diet-humans-study-a8378631.html), one can reduce one's carbon footprint by 73% by switching to a vegan diet! Further, as [noted](https://www.prweb.com/releases/edamam_launches_an_immunity_supporting_diet_and_meal_recommender_for_the_covid_19_era/prweb17168115.htm) by Dr Deanna Minich, food items that help boost immunity could help one in COVID-19 prevention and recovery.

### Function

Victus enables the user to capture an image of a food item and uses a machine learning model to classify it. Then, it makes a few API calls to Edamam to extract nutritional information — calories, protein, fat, carbohydrates, and fibres — and inform the user with environmentally-sustainable recipes, which include vegan, immunity-boosting, and keto alternatives. 

### Construction

The original plan was to create Victus using React Native and Python Flask. However, we pivoted to building an iOS application using Swift to better take advantage of native tools available to developers such as CoreML and SwiftUI. We build the user interface primarily using SwiftUI and used the [Food101](https://github.com/ph1ps/Food101-CoreML) CoreML model to classify the food item. Image transformation helpers were used to scale the captured image to the dimensions required by the model. The model's output result was then parsed and sent over to the Edamam Food Database via an API call to obtain the required information. This is then displayed to the user through a dismissable modal sheet.

### Challenges

The challenges we faced were in regards to connecting and sending data between the third-party tools we chose to use. Specifically, extracting the data received through the Edamam API call proved to be a challenge. Through experimentation, however, we figured it out just a few hours before the hackathon deadline! Other minor challenges included the resizing and cropping of the image and familiarising ourselves with Swift and Xcode in general. We can't deny that Apple's documentation and a few posts on Stack Overflow, which are listed below, saved us quite a lot of time.

### Accomplishments

All members of our team are not only passionate about technology but also about using it to aid in pressing social issues facing society today. Through the course of the hack, our team gained significant experience in rapid prototyping and development, and we believe that this was our most significant accomplishment. And although Victus is primitive as a functional application, it made us realise the meaningful impact of apps that promote environmental-sustainability and healthy living. We're also quite pleased that we incorporated a 'fact-finding' mission in our development cycle, which ultimately provided the app purpose. We [identified](https://ourworldindata.org/food-choice-vs-eating-local) that our daily diets have an impact on greenhouse gas emissions than transportation and that a vegan diet was the most sustainable option! We're proud to be able to create a solution that helps educate users on making the right choice for their health and our environment.

### Reflection

Building Victus has been a valuable learning opportunity for the entire team. With the team being relatively new to mobile app development and machine learning, we gained quite a bit of experience in connecting the dots. We believe that such experiences broaden the scope of our development knowledge and help us adapt to a wide range of challenging situations.

### Future

Although our team is composed of students working under strict academic schedules, we do plan to continue the development of Victus for iOS as an opportunity to understand the 'quirks and features' of iOS development. We intend to add more features to the app, such as an option to upload an image and the ability to provide allergy information. 

### References

Oxford Hack Submission Video: [YouTube](https://youtu.be/A8DvlulOE4U)  
Devpost Project: [Devpost](https://devpost.com/software/victus)

#### Stack Overflow
- [How to Convert a UIImage to a CVPixelBuffer](https://stackoverflow.com/questions/44462087/how-to-convert-a-uiimage-to-a-cvpixelbuffer)
- [Swift - Cropping an Image to Remove Bottom Part](https://stackoverflow.com/questions/60617982/swift-cropping-an-image-to-remove-bottom-part)
- [How to Resize an Image in Swift](https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift)

#### Other
- [Connecting SwiftUI to CoreML](https://www.hackingwithswift.com/books/ios-swiftui/connecting-swiftui-to-core-ml)
- [How to Access Photo Library and Use Camera in SwiftUI](https://www.appcoda.com/swiftui-camera-photo-library/)
