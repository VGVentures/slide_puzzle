# template

This template is to reduce the boilerplate involved in setting up a new Flutter project. This template repository contains multiple branches, each with successively more configuration.

## base

- Basic project via Flutter create
	- Lock Flutter version to latest beta
	- Global Flutter error handlers
	- Support for Android release signing
	- Updated .gitignore
- Flavors
	- `development`, `staging`, `production`
	- Custom bundle id, display name, and launcher icons for each
- VGV static analysis rules
	- Pedantic package
	- Custom VGV rules
- Shared IntelliJ configurations
	- Flavor run configurations
	- Shared code styles
	- Shared dictionary
- Github configurations
	- Codeowners file
	- Pull request template
	- Workflow that runs Flutter static analysis and tests on every pull request

## firebase

- All of `base`, plus flavor-specific Firebase configurations


## How to Use

1. Clone the desired branch of this repo.
1. Update the bundle id, package name, and display name. At the root of the repo, run:

	```
	./replace.py -o com.flutter.template -n com.domain.yourapp
	./replace.py -o template -n yourapp
	./replace.py -o AppName -n YourApp
	```
1. Rename the folders in `android/app/src/main/kotlin` to represent your app's bundle id.

You should now be able to run your app on both iOS and Android, in all 3 flavors.

## Continous Integration

This template comes with a Github Action workflow at `.github/workflows/main.yaml` that runs `flutter analyze` and `flutter test` on every pull request. This workflow uses the latest version of [flutter-action](https://github.com/marketplace/actions/flutter-action). The `flutter-version` in this file must be kept in sync with the one specified in `pubspec.yaml`.

When using this template for your own Flutter repo, you should configure Github to require this workflow as a precondition for merging pull requests. Go to `Settings` → `Branches` → `Branch Protection Rules` and select `Require status checks to pass before merging` for your branches.

## Launcher Icons

Create a 1024x1024px graphic to use for the icon, one for every flavor.

### iOS

1. Go to [https://appicon.co](https://appicon.co) and upload the graphic.
2. Select all options except `Mac` and `Android` and click `Generate`.
3. Download and open the resulting `AppIcons.zip` file.
4. Open the resulting `Assets.xcassets` folder.
5. Locate the `AppIcon.appiconset` folder.
6. Open Xcode and in the Project Navigator go to `Runner` → `Runner` → `Assets.xcassets`.
7. Delete the existing `AppIcon` you wish to replace.
8. Rename the folder in step 5 to `AppIcon-Development.appiconset` or `AppIcon-Staging.appiconset` if updating the non-production icon.
9. Drag and drop the folder into Xcode next to the other icons assets.
10. Repeat steps 7-9 for other flavors.

### Android

1. Open the `android` folder in Android Studio as a separate project.
2. In the `Project` window, select `Project` view.
3. Navigate to `android` → `app` → `src`.
4. For every flavor folder (`production` is `main`), right-click the `res` folder and select `New` → `Image Asset`.
5. Go to `Foreground Layer` → `Source Asset` → `Path` and select the original icon graphic you created for the flavor.
6. Go to `Background Layer` → `Source Asset` → `Asset Type` and select `Color`.
7. Click on the color button and enter a suitable color for the background layer. If not sure just select white.
8. Click the `Next` button.
9. Select the `Res Directory` that matches the flavor you are updating. For `production`, select `main`.
10. Click the `Finish` button.
11. Repeat steps 3-10 for the other flavors.

## Debug Builds

1. Install the [Flutter SDK](https://flutter.dev/docs/get-started/install) and follow all instructions
1. Set your Flutter channel to `beta` by running `flutter channel beta`
1. Android Studio is the preferred IDE for this project. Install [Android Studio](https://developer.android.com/studio) and install the `Flutter` plugin.
1. Install [Cocoapods](https://cocoapods.org) by running `sudo gem install cocoapods`.
1. Open the repo folder in Android Studio, select a flavor from the run configuration drop-down, and select the `Run` or `Debug` command to run the app in the selected simulator/emulator.
1. If you get an error, verify that your Flutter version (`flutter --version`) is equal to the version specified in the `pubspec.yml` file.

## Release Builds

### iOS

Coming soon 

### Android

1. When creating a new app, generate a new keystore in the `android/app` folder. *Do* commit this file to source control.

	```
	keytool -genkey -v -keystore app.keystore -alias app -storepass password -keyalg RSA -keysize 2048 -validity 10000	
	```
1. In the `android/` folder, create a `key.properties` file containing the keystore password in the form of `storePassword=xxx`. *Do not* commit this file to source control (it is .gitignored by default).
1. Run `flutter build appbundle --flavor [flavor]` from the root of the repo, where `flavor` is `development`, `staging`, or `production`. Alternatively, a CI tool can provide the store password in the form of an environment variable named `storePassword`.
1. A signed Android app bundle will be generated, ready for distribution.

## Troubleshooting

### Android

If you run into issues running on Android, follow the following steps:

1. Run `flutter clean` from the root of the repo.
1. In Android Studio, go to `File` → `Invalidate Caches and Restart`.
1. Select `Invalidate and Restart`.

### iOS

If you run into issues running on iOS, follow the following steps:

1. Run `flutter clean` from the root of the repo.
1. Open Xcode → `Preferences` → `Locations` → `Derived Data`. Open this folder in Finder. Close Xcode. Delete the contents of this folder. Restart Xcode.
1. Run `pod repo update` to update your local cache of the Cocapods spec repository.
1. In the `ios` folder, run `pod update [pod]` replacing `pod` with the name of the pod giving you trouble, i.e. `Firebase/RemoteConfig`.