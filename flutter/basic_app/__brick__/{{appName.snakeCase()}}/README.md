# Flutter Basic App

Flutter Basic App

# Prerequisite

- Flutter
- Fvm
- Flutterfire CLI

## Getting Started


1. Get all the dependencies listed in the pubspec.yaml:
   ```
   fvm flutter pub get
   ```

2. Run ```build_runner``` command.
   ```
   fvm flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Firebase setup:

    Run following command to setup firebase option

    Create firebase project before running this command.
     ```
     flutterfire configure 
     ```
    
    + Add and setup all firebase login options needed in firebase console.

    + Setup firebase notification for Ios and Android (```certficates```).

    + Uncomment the ```_updateFcmToken()``` function inside ```initState``` in ```home_page.dart``` after implementing the ```updateToken``` endpoints.

    + setup ios and android spesific setting for google sign in if needed

    + setup ios and android spesific setting for facebook sign in if needed

    + setup ios and android spesific setting for apple sign in if needed

    + After implementing the login and signup endpoints uncomment following endpoint calls
        ```
        await useAuthenticationService().login;
        ```
        or
        ```
        await useAuthenticationService().signup;
        ```
       inside ```register_page.dart``` , ```signin_page.dart``` and ```signup_page.dart``` .

4. Remove dummy from config files ```dummy.dev.config.json``` and ```dummy.production.config.json``` setup ```lib/utils/env.dart``` :

    + add baseUrl for api 
    + add other enviroment spesific variables like stripe key

5. Android spesific:

    remove dummy from ```dummy.key.properties``` and set the right properties

6. For running the App in Debug Mode make sure the correct config setting is selected in ```RUN AND DEBUG``` Tab in Vscode 

## Build 
Use Build sh files to build the project based on the enviroment needed.

for Example:
```
sh build_production_ios.sh
```
 
+  build_production_ios.sh
+  build_production_android.sh
+  build_dev_ios.sh
+  build_dev_android.sh