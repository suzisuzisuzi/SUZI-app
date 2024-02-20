![app](https://github.com/suzisuzisuzi/SUZI-app/assets/81961406/d36ed341-0292-41f1-aee6-5c2509e2e427)
# SUZI Flutter App
This is the flutter app for the SUZI Project for the Google Solution Challenge 2024 by Team TBD.

## Instructions to Run
Create a .env file at the root of the project and add the following environment variables for backend host URL. Make sure your backend server is running. To know more about the backend server, visit [SUZI Backend](https://github.com/suzisuzisuzi/SUZI-backend).
```
BASE_URL=<BACKEND URL>
```
Make sure to have flutter installed on your system and an Android/iOS Simulator running.
Install FlutterFire CLI tools by running the following command.
```
flutter pub global activate flutterfire_cli
```
Configure Firebase by running the following command.
```
flutterfire configure
```
 Run the following commands to start the app.
```
flutter pub get
flutter run
```
