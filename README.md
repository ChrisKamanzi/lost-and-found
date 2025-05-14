📱 Lost and Found Flutter App

A mobile application built using Flutter and Laravel that allows users to post and search for lost and found items in their local community. The app provides a seamless interface to report items, browse categorized posts, chat with item owners, and manage user accounts.

📌 Features

. User Authentication (Login / Signup / Password Reset)

.Create & view lost/found item ads

. Image upload for lost/found items.

. Search and filter items by categories.

. views for item details 

. chat functionality

. Map funcrionality. 

📁 Project Architecture

lib -
     
     -Constant
     
     -Models
     
     -Pages
     |       -Aunthentication 
     |       -CreatAd
     |       -Home
                      -LostAndFound
                      -Home.dart
     |      -Message
     |      -SearchOnMap
     -Providers
     -Widgets
     -main.dart

🛠 Technologies & Packages Used

Package|	                       Version|	                 Purpose

Flutter SDK |	              >=3.7.2|	                Core framework

flutter_riverpod|	         ^2.4.0|	                State management

go_router|             ^14.8.1|	                Navigation and routing

dio|	                      ^5.8.0+1|	                Networking (API calls)

shared_preferences |    	      ^2.3.5|	                Persistent local storage

image_picker|	              ^1.1.2|	                Image selection from gallery/camera

google_fonts|	              ^6.2.1|	                Beautiful custom fonts


flutter_map|	              ^8.1.1|	                Map rendering using OpenStreetMap

geolocator|	              ^14.0.0|	                Location services

lottie|	                      ^2.7.0|	                Animated success/motivation feedback

dropdown_button2|	      ^2.3.9|	                Enhanced dropdown menus

animated_page_reveal|	      ^1.0.0|	                UI transition animations

mockito|	                      ^5.4.0|                Mocking dependencies for testing

build_runner|	              ^2.4.0|	               Code generation for mockito tests

flutter_test|	             SDK|	                Unit and widget testing


🛠 Setup Instructions

. Flutter SDK installed (version >=3.7.2)

. Android Studio or VS Code

. Emulator or real device connected

🚀 Run the App

1 - Clone the Projects

git clone https://github.com/ChrisKamanzi/lost-and-found
cd lost-and-found

2 - Install dependencies:

flutter pub get

3 - Run the app:

flutter run 

🧪 Running Tests

flutter test

 







