# 📚 Online Learning Platform

A comprehensive Flutter-based online learning platform that provides students with access to courses, live classes, assignments, quizzes, and educational resources.

## 🎯 Features

### 🔐 Authentication & User Management
- **Phone Number Authentication**: Secure login using mobile number and OTP verification
- **Firebase Authentication**: Integrated with Firebase for reliable user authentication
- **User Profiles**: Complete user profile management with edit capabilities
- **Course Selection**: Initial course selection during onboarding

### 📖 Learning Features
- **Course Dashboard**: Browse and access enrolled courses
- **Live Classes**: Join live streaming classes with real-time chat
- **Recorded Classes**: Access previously recorded class sessions
- **PDF Viewer**: Read course materials and documents
- **Video Player**: Watch educational videos with quality controls
- **Assignments**: Complete and submit assignments
- **Quizzes & Tests**: Take assessments and view results
- **Test Series**: Access comprehensive test series for exam preparation
- **Progress Tracking**: Monitor learning progress and performance

### 🛒 E-commerce Features
- **Book Store**: Browse and purchase educational books
- **Shopping Cart**: Add items to cart and manage orders
- **Wishlist**: Save favorite courses and books for later
- **Payment Integration**: Secure payment processing with Razorpay
- **Order Management**: Track order status and history
- **Book Reviews**: Read and write reviews for books

### 💬 Communication & Support
- **Real-time Chat**: Live chat functionality using Socket.IO
- **Group Discussions**: Participate in course-related discussions
- **Help & Support**: Get assistance through support queries
- **Push Notifications**: Receive updates about classes, assignments, and announcements

### 🔍 Additional Features
- **Search Functionality**: Search for courses, books, and content
- **Filter & Sort**: Advanced filtering options for better content discovery
- **Offline Support**: Download content for offline access
- **YouTube Integration**: Access supplementary YouTube videos
- **Multi-language Support**: Support for different languages
- **Dark/Light Theme**: Customizable app appearance

## 🏗️ Technical Architecture

### 📱 Frontend
- **Framework**: Flutter (Dart)
- **State Management**: GetX
- **Architecture**: MVC (Model-View-Controller)
- **UI Components**: Custom widgets with Material Design
- **Animations**: Flutter Animate for smooth transitions

### 🔧 Key Dependencies

```yaml
dependencies:
  flutter: sdk: flutter
  
  # Firebase Services
  firebase_core: ^3.12.0
  firebase_messaging: ^15.2.3
  firebase_auth: ^5.5.0
  
  # State Management & Navigation
  get: ^4.7.2
  get_it: ^8.0.3
  
  # UI Components
  cupertino_icons: ^1.0.6
  flutter_local_notifications: ^18.0.1
  fluttertoast: ^8.2.12
  gradient_borders: ^1.0.1
  pinput: ^5.0.1
  flutter_spinkit: ^5.2.1
  skeletonizer: ^2.1.0+1
  flutter_animate: ^4.5.2
  flutter_rating_bar: ^4.0.1
  
  # Data Visualization
  syncfusion_flutter_charts: 27.2.5
  syncfusion_flutter_pdfviewer: 27.2.5
  
  # Media & Images
  cached_network_image: ^3.4.1
  carousel_slider: ^5.0.0
  image_picker: ^1.1.2
  
  # Video Playback
  chewie: 1.8.7
  video_player: ^2.10.0
  
  # Networking & API
  http: ^1.1.0
  dio: ^5.8.0+1
  socket_io_client: ^3.1.1
  
  # Payment Integration
  razorpay_flutter: ^1.4.0
  
  # Storage & Preferences
  shared_preferences: ^2.3.2
  
  # System Integration
  permission_handler: ^11.3.1
  url_launcher: ^6.3.1
  app_settings: ^6.1.1
```

### 📁 Project Structure

```
lib/
├── controllers/           # GetX Controllers for state management
│   ├── auth_controller/
│   ├── dashboard_controller/
│   ├── home_controller/
│   ├── book_controller/
│   ├── quiz_controller/
│   └── ...
├── data/                  # Data layer
│   ├── api_controller/
│   ├── api_service/
│   ├── firebase_service/
│   └── app_environment/
├── models/               # Data models
│   ├── course_detail_model/
│   ├── user_signin_model/
│   ├── payment_model/
│   └── ...
├── utils/                # Utility classes
│   ├── app_colors/
│   ├── app_images/
│   ├── app_routes/
│   ├── widget_component/
│   └── shared_preferences/
├── view/                 # UI Screens
│   ├── auth_view/
│   ├── dashboard_page_view/
│   ├── home_page_view/
│   ├── shop_view/
│   ├── quiz_view/
│   └── ...
└── firebase_options.dart # Firebase configuration
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.4.0 <4.0.0)
- Dart SDK
- Android Studio or VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd study_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Add your Android/iOS app to Firebase
   - Download and add the configuration files:
     - `android/app/google-services.json` for Android
     - `ios/Runner/GoogleService-Info.plist` for iOS
   - Configure Firebase Authentication, Cloud Messaging, and other services

4. **Run the application**
   ```bash
   flutter run
   ```

### Environment Configuration

The app supports multiple environments:
- **Development**: `lib/data/app_environment/dev.dart`
- **Production**: `lib/data/app_environment/prod.dart`
- **Local**: `lib/data/app_environment/local.dart`

## 🔧 Configuration

### API Configuration
Update the API URLs in `lib/data/api_url/api_url.dart` according to your backend endpoints.

### Firebase Configuration
Ensure Firebase services are properly configured:
- Authentication
- Cloud Messaging
- Cloud Firestore (if used)
- Storage (if used)

### Payment Gateway
Configure Razorpay credentials for payment processing.




## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.


## 🔮 Future Enhancements

- [ ] Advanced analytics dashboard
- [ ] Social learning features
- [ ] Gamification elements
- [ ] Advanced search with AI
- [ ] Multi-platform support (Web, Desktop)
- [ ] Offline content synchronization
- [ ] Advanced video streaming features
- [ ] Integration with more payment gateways

---
