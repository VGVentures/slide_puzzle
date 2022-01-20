# NOTES FOR FORKING NFT PUZZLE FUN
#### fork the repo
```
npm install firebase
npm install -g firebase-tools
firebase login
firebase init
firebase deploy
dart pub global activate flutterfire_cli
flutterfire configure
```

#### find replace package:very_good_slide_puzzle with package:[mypackagename]

https://firebase.flutter.dev/docs/overview/

Make sure and set the current android sdk in android studio project settings: https://stackoverflow.com/questions/56938436/first-flutter-app-error-cannot-resolve-symbol-properties

```
firebase deploy --only hosting
```


## copy in private configs:
```
chrisfulton@pop-heiress nftpuzzlefun % cp ../nftpuzzlefun_with_keys_PRIVATE/android/app/google-services.json android/app 
chrisfulton@pop-heiress nftpuzzlefun % cp ../nftpuzzlefun_with_keys_PRIVATE/ios/Runner/GoogleService-Info.plist ios/Runner/
chrisfulton@pop-heiress nftpuzzlefun % cp ../nftpuzzlefun_with_keys_PRIVATE/macos/Runner/GoogleService-Info.plist macos/Runner/
chrisfulton@pop-heiress nftpuzzlefun % cp ../nftpuzzlefun_with_keys_PRIVATE/lib/firebase_options.dart lib 
chrisfulton@pop-heiress nftpuzzlefun % cp -R ../nftpuzzlefun_with_keys_PRIVATE/.firebase .firebase
chrisfulton@pop-heiress nftpuzzlefun % cp -R ../nftpuzzlefun_with_keys_PRIVATE/nftpuzzlefun.jks . 
```

