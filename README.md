# 📱 Lost and Found Flutter App

A mobile application built using **Flutter** and **Laravel** that enables users to post and search for lost and found items within their local community. The app provides a seamless experience to report items, browse categorized posts, chat with item owners, and manage user accounts.

---

## 📌 Features

- User Authentication (Login / Signup / Password Reset)
- Create and view lost/found item ads
- Upload images for lost/found items
- Search and filter items by category
- View detailed item information
- Real-time chat functionality
- Interactive map integration

---

## 📁 Project Architecture


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



---

## 🛠 Technologies & Packages Used

| Package | Purpose |
|--------|---------|
| [flutter_riverpod](https://pub.dev/packages/riverpod) | State management |
| [go_router](https://pub.dev/packages/go_router) | Navigation and routing |
| [dio](https://pub.dev/packages/dio) | Networking (API calls) |
| [shared_preferences](https://pub.dev/packages/shared_preferences) | Persistent local storage |
| [image_picker](https://pub.dev/packages/image_picker) | Image selection from gallery/camera |
| [google_fonts](https://pub.dev/packages/google_fonts) | Custom fonts |
| [flutter_map](https://pub.dev/packages/flutter_map) | Map rendering using OpenStreetMap |
| [geolocator](https://pub.dev/packages/geolocator) | Location services |
| [lottie](https://pub.dev/packages/lottie) | Animated feedback |
| [dropdown_button2](https://pub.dev/packages/dropdown_button2) | Enhanced dropdown menus |
| [animated_page_reveal](https://pub.dev/packages/animated_page_reveal) | UI transition animations |
| [mockito](https://pub.dev/packages/mockito) | Mocking dependencies for testing |
| [build_runner](https://pub.dev/packages/build_runner) | Code generation for testing mocks |

---

## 🛠 Setup Instructions

- Flutter SDK (>= 3.7.2)
- Android Studio or VS Code
- Emulator or physical device

---

## 🚀 Run the App

1. **Clone the repository**
   ```bash
   git clone https://github.com/ChrisKamanzi/lost-and-found
   cd lost-and-found


2 - Install dependencies:

<pre> flutter pub get </pre>

3 - Run the app:

<pre> flutter run  </pre>

## 🧪 Running Tests

<pre> flutter test </pre>

 







