Victus is a project that gives the nutritional information of food and provides sustainable/vegan alternatives and recipes and immune boosting recipes as well.

#Inspiration

Eating habits have always had a major impact not only on our own immunity but also on the environment as well and lockdowns have only made our eating habits worse. This is why we wanted to develop Victus, an iOS application that displays the nutritional information of food which it scans and also notifies the user about more sustainable food choices, food choices that can boost immunity given the current Covid-19 situation and generally more nutritious options. Changing eating habits is key for sustainability since according to Oxford University switching to a vegan diet can reduce one’s carbon footprint by 73%! This is significantly more than if an individual decided to simply only use public transit. This is why in our app we give a sustainable food alternative by recommending vegan recipe alternatives. Furthermore picking foods which boost immunity can help in Covid-19 prevention and recovery as noted by Deanna Minich, Phd.

Sources: Oxford Sustainability: https://www.independent.co.uk/life-style/health-and-families/veganism-environmental-impact-planet-reduced-plant-based-diet-humans-study-a8378631.html

Deanna Minich, immune boosting foods and impact on Covid-19 https://www.prweb.com/releases/edamam_launches_an_immunity_supporting_diet_and_meal_recommender_for_the_covid_19_era/prweb17168115.htm

#What it does

Victus allows the user to capture an image of any type of food whether it be fast food, vegetables, fine dining to a chip bag. The app then uses machine learning to classify the image of the food and notes all the nutritional information related to the food including its calorie count, protein count, fat content and carbohydrate content. In addition to this the application then gives the user recommendations on different recipes which are more sustainable for the environment by specifically listing a vegan alternative, more immune boosting or even keto-friendly recipes.

#How we built it

The original plan was to create a react native application which would call a Python Flask REST API which would classify the image and give the nutrition information. However we soon pivoted to building a native iOS app using Swift in order to better take advantage of the better native tools available to us with Swift (such as the InceptionV3 ML Model). We built the application’s user interface primarily using SwiftUI and added camera functionality to record a picture when the user uses the camera to capture a picture of the food. From here we sent the image to the InceptionV3 ML Model which then classified the image and using this classification connected the Edamam Food Database to get the nutrition information of the food and also to get more sustainable, healthy and immune boosting alternatives.

#Challenges we ran into

The primary challenges we faced were in regards to connecting and sending data between all the third party tools available to us. One of the toughest challenges specifically was actually being able to send the picture not only to the MLModel but to also send the classification to the Edamam API and get the data from the Edamam API as well. The lack of documentation for the Edamam API made it difficult to make sure that we were using the correct API calls however through experimentation we soon were able to find a solution to this problem. Further challenges included understanding Swift code and learning the ins and outs of Xcode since our whole team was very new to native iOS application development however using resources like the Apple documentations and Stack Overflow this did not significantly disrupt our development timeline.

#Accomplishments that we're proud of

All of the team members are not only very passionate about technology but also about using technology to aid in pressing social issues facing society today. This is why the greatest accomplishment of our team in this Hackathon is being able to create an application that can have a real meaningful impact when it comes to sustainability and building immunity. By keeping the issue of sustainability in our development cycle we soon realized that our diets actually have a much larger impact on greenhouse gas emissions compared to transportation. We also realized that eating a vegan diet is the most sustainable option so we made sure that our app notes sustainable options by listing vegan alternatives. Being able to recognize this problem but then also build a technological solution that can also help others educate themselves on making sustainable choices is another great accomplishment our team had over the hackathon.

Source on why diets play a larger role on controlling greenhouse gas emissions when compared to transportation: https://ourworldindata.org/food-choice-vs-eating-local

#What we learned

Completing this application has been an amazing learning achievement for all of us. With all of the team being relatively new to mobile application development in general and also not having experience in regards to machine learning we learned a lot not only how to connect to different tools but also how exactly image classification works and how to call APIs in a mobile device. Furthermore, one of the most important learnings was actually in mobile design for the application. Mobile application design is very different from the web application design the team is used to and being able to really see how to optimize the application for mobile, such as where to place certain buttons and how to indicate to the user the next steps was very interesting to experience and learn.

#What's next for Victus

The upcoming plan regarding Victus is to develop it into a multi-platform application where users from Android and Web Browsers are able to access the application. We have already begun development for this as we have a working Python Flask REST API which calls Google Cloud Vision services, for the front end we are using React Native and have developed a working camera module in it so far. Our idea is that soon after the hackathon, we will have a React front-end developed to run Victus on web browsers and further increase the user base. We intend to add more features in Victus, such as an option to upload the image instead of clicking it, giving allergy notifications and also providing data about various other diets a user could try depending on the food that they’re searching. These additional features paired with the iOS application and the React Native application will give Victus the reach needed to connect to more users on all major platforms.
