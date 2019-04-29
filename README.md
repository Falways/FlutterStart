# FlutterStart
This is my flutter study

# How to install flutter
	flutter is base on dart, but we just to install the flutter.
	1. download pkg
		uri:https://storage.googleapis.com/flutter_infra/releases/stable/windows/flutter_windows_v1.2.1-stable.zip
	2. config environment variables
		Extract the zip file and place the contained flutter in the desired installation location for the Flutter SDK (eg. C:\src\flutter; do not install Flutter in a directory like C:\Program Files\ that requires elevated privileges).
		Locate the file flutter_console.bat inside the flutter directory. Start it by double-clicking.
		If you wish to run Flutter commands in the regular Windows console, take these steps to add Flutter to the PATH environment variable:
		From the Start search bar, type ‘env’ and select Edit environment variables for your account
		Under User variables check if there is an entry called Path:
		If the entry does exist, append the full path to flutter\bin using ; as a separator from existing values.
		If the entry does not exist, create a new user variable named Path with the full path to flutter\bin as its value.
		Note that you will have to close and reopen any existing console windows for these changes to take effect.
	3. Run flutter doctor
		From a console window which has the Flutter directory in the path (see above), run the following command to see if there are any platform dependencies you need to complete the setup
	Tips:
		If you are in china , you need config mirror extra
		like this:
			export PUB_HOSTED_URL=https://pub.flutter-io.cn
			export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Quik start demo, only 3 steps
	Use the flutter create command to create a new project:
	1. flutter create myapp
	2. cd myapp
	Run the app:
	Check that an Android device is running. If none are shown, follow the device-specific instructions on the Install page for your OS.
	3. flutter devices
	4. flutter run
	

