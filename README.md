# IOS-Visualisations-App

An iOS companion app for Imperial Visualisations. For use in lectures and tutorials.

Built for use with iOS 13 beta.
Testing device - iPhone X

To begin open 'VisualisationsUIKit.xcodeproj' in a copy of the XCode 11 beta.

Current Features:
- A scrollable, dynamic list with all available visualisations where the the data is fetched from a hosted JSON file
- Some visualisation pages, eg 'Two Body Collisions' fit well onto the smaller screen
- Search functionality
- Ability to 'Peak & Pop' each cell of the list to view a short of GIF of the visualisation before committing to a segue
- iOS 13 dark mode compatible
- Animated splashscreen on app launch while JSON data is fetched
- Checks internet access status at app launch - see TODO


TODO:
- Change CSS styling of visualisation pages to ensure they scale correctly on a phone screen, with excess information removed
- Move JSON datasource to server
- Update app to make use of the new visualisation 'suites' structure - significantly different from current structure
- Inform the user when unable to connect to the internet both during splash screen and in app. The 'reachability' library is buggy here - contact developers
- Ensure scaling is correct on the iPad even though the app is targetted for iPhones
