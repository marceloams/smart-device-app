<img src="https://github.com/marceloams/smart-device-app/blob/master/assets/images/readme/header-readme.png?raw=true">

---

# Smart Device App [![Build Status](https://travis-ci.com/marceloams/smart-device-app.svg?branch=master)](https://travis-ci.com/marceloams/smart-device-app) [![pt-br](https://img.shields.io/badge/lang-pt--br-green.svg)](https://github.com/marceloams/smart-device-app/blob/master/README.pt-br.md)

---

## 📱 Application 

- Part of the Smart Device Project;

- It is mean to be used with [library for ESP8266 microcontroller](https://github.com/marceloams/smart-device-library) and [API](https://hub.docker.com/repository/docker/marceloams/smart-devices-api);

- Mobile and Web application for monitoring and manage modular sensors connected to the internet; 

- The app is divided in two parts: 
  - Mobile App (branch master);
  - Web App (branch temporary-web-version);

- Temporary web version (at the time, Flutter 2.0 had just been released and some libraries didn't have support for Flutter Web).

---

## 📝 Features 

#### The project has the following features:

- [x] Add devices;
- [x] List devices;
- [x] Devices settings;
- [x] Delete devices;
- [x] Real time reading of the device's measurements;
- [x] List of the measurements;
- [x] User registration;
- [x] User seetings.

---

## 📲 App Screens

#### The application has the following screens:

<img src="https://github.com/marceloams/smart-device-app/blob/master/assets/images/readme/Screens-readme-user.png?raw=true">
<img src="https://github.com/marceloams/smart-device-app/blob/master/assets/images/readme/Screens-readme-device.png?raw=true">

---

## 🛠️ Tools 

#### The following tools were used in the development of the project:

[![marceloamsProductions](http://img.shields.io/badge/-Dart-0175C2?style=flat&logo=Dart&logoColor=white)](https://dart.dev/)
[![marceloamsProductions](https://img.shields.io/badge/-Flutter-3a495d?style=flat&logo=flutter&logoColor=67b7f7)](http://flutter.dev)
[![marceloamsProductions](http://img.shields.io/badge/-Android%20Studio-3DDC84?style=flat&logo=Android%20Studio&logoColor=black)](https://developer.android.com/studio)
[![marceloamsProductions](https://img.shields.io/badge/-Firebase-3a495d?style=flat&logo=Firebase&logoColor=FFCA28)](https://firebase.google.com/)
[![marceloamsProductions](https://img.shields.io/badge/-Travis-B10000?style=flat&logo=Travis)](https://travis-ci.org/)

---

## 📚 Libraries 

#### The following libraries were used in the development of the project:

- <a href="https://pub.dev/packages/firebase_database" target="_blank">firebase_database</a>;
- <a href="https://pub.dev/packages/firebase_core" target="_blank">firebase_core</a>;
- <a href="https://pub.dev/packages/clipboard" target="_blank">clipboard</a>;
- <a href="https://pub.dev/packages/mockito" target="_blank">mockito</a>;
- <a href="https://pub.dev/packages/flutter_launcher_icons" target="_blank">flutter_launcher_icons</a>;
- <a href="https://pub.dev/packages/auth_buttons" target="_blank">auth_buttons</a>;
- <a href="https://pub.dev/packages/firebase_auth" target="_blank">firebase_auth</a>;
- <a href="https://pub.dev/packages/google_sign_in" target="_blank">google_sign_in</a>;
- <a href="https://pub.dev/packages/flutter_facebook_auth" target="_blank">flutter_facebook</a>;
- <a href="https://pub.dev/packages/firebase_storage" target="_blank">firebase_storage</a>;
- <a href="https://pub.dev/packages/auth_buttons" target="_blank">auth_buttons</a>;
- <a href="https://pub.dev/packages/cloud_firestore" target="_blank">cloud_firestore</a>;
- <a href="https://pub.dev/packages/multiavatar" target="_blank">multiavatar</a>;
- <a href="https://pub.dev/packages/flutter_svg" target="_blank">flutter_svg</a>;
- <a href="https://pub.dev/packages/fake_cloud_firestore" target="_blank">fake_cloud_firestore</a>;
- <a href="https://pub.dev/packages/firebase_auth_mocks" target="_blank">firebase_auth_mocks</a>;
- <a href="https://pub.dev/packages/google_sign_in_mocks" target="_blank">google_sign_in_mocks</a>;
- <a href="https://pub.dev/packages/flutter_native_splash" target="_blank">flutter_native_splash</a>;
- <a href="https://pub.dev/packages/firebase" target="_blank">firebase (only used in the web version)</a>;

---

## 📁 Repository structure

- <a href="https://github.com/marceloams/smart-device-app/tree/master/lib" target="_blank">Production codes</a>;
- <a href="https://github.com/marceloams/smart-device-app/tree/master/test" target="_blank">Test codes</a>.

---

## ⚡ How to use - step by step

  
### Via APK 💿

#### Requirements

  - At least Android 4.1 - Jelly Bean (API 16);

#### Operation

 - <a href="https://github.com/marceloams/smart-device-app/releases/download/0.1/app-release.apk" target="_blank">Download the APK into your device</a>

### Via Code 💻

#### Requirements

  - Flutter SDK;
  - Android Studio or Visual Studio Code;
  - Android SDK;
  - Java JDK;
  - An emulator or a device to test the application.
 
#### Test your enviroment 

Run the following command at the command prompt:

```
flutter doctor
```

If something went wrong, here is a [tutorial](https://medium.com/@sahaj.blup/flutter-development-environment-setup-a-step-by-step-guide-5e457583bc4d) on how to configure the development environment.

### Step 1

- **Option 1**
    - 🍴 Fork this repository!

- **Option 2**
    - 👯 Clone to your machine.

#### Step 2

  - Open the project and launch the emulator or connect your device.
 
#### Step 3

- At the command prompt within the project directory, run the following commands:

```
flutter pub get
flutter run
```

 #### Step 4 (Opcional)
 
 - Finally, if you wish, follow the steps mentioned in the [library for ESP8266 microcontroller](https://github.com/marceloams/smart-device-library) and [API](https://hub.docker.com/repository/docker/marceloams/smart-devices-api)
 
---
 
✔️ If you've followed the steps and were successful, it's a sign that it worked!
<br>
<br>
<img src="https://media.giphy.com/media/nDSlfqf0gn5g4/giphy.gif">
<br>
<br>
❌ If any of the steps didn't work, something wrong isn't right! (Make an issue)
<br>
<br>
<img src="https://media.giphy.com/media/wofftnAdDtx4s/giphy.gif">

---

## 🔨 Contribution

### Step 1

- **Option 1**
     - 🍴 Fork this repository!

- **Option 2**
     - 👯 Clone to your current machine.

### Step 2

- **Coding!** 👨‍💻👩‍💻

### Step 3

- 🔃 Create a new pull request.

  ---
 
  ## 👨‍💻 Authors


| **Marcelo Amorim** | **Caio Souza** |
| :---: | :---: |
| [![SmartDeviceAppProductions](https://avatars1.githubusercontent.com/u/63866348?&v=4&s=200)](https://github.com/marceloams) | [![SmartDeviceAppProductions](https://avatars1.githubusercontent.com/u/21149887?&v=4&s=200)](https://github.com/CaioHpSouza) |

---
 
 ## ©️ License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2020 © <a href="https://github.com/marceloams/smart-device-app" target="_blank">SmartDeviceAppProductions</a>.

---

