# MindValley_Test
MindValley pinterest test

## Application is built using MVVM architecture.

1. ImageDetailModel(Model) - consists the properties related to Image detail API.
2. PinterestCollectionViewController(View) - consists the actions and loading of UI objects on the view.
3. PinterestCollectionViewModel(ViewModel) - consists of the business logic where the network call is made for fetching token and north and south trams.
4. PinterestCollectionViewCell - consists the cell which is getting loaded depending on the data provided

## Network Layer is seperate with generic methods for reading the files using URLSession. It consists of 

1. NetworkManager - Consisting of the genric protocol based methods for fetching and decoding JSONs.
2. Reachability - To check the connectivity to internet.
3. ImageDetailFetchRequest/ImageDetailFetchManager - Creation and triggering of the URL request for fetching the image list and its detail from the json.
4. ImageDownloadRequest/ImageDownloadManager - Setting and triggering of the URL request for downloading the image from the url.
5. CacheManager - Singleton class with methods to set limits to the cache, set object, get object to the URL


## Utils classes are also present which give generic functionality which can be used throughout the applications

1. Extensions - Extensions written for classes(i.e UIViewController, UIColor) for adding alerts, activity indicator, getting color from hexstring etc.
2. AppConstants - Application constants used throughout the app. Strings, Enums, Errors etc


## Unit and UI XCTestCases with coverage of 91.9%(screenshot added).

1. CacheManagerTests - Testing the CacehManager methods.
2. NetworkCallsTest - Testing the NetworkManager methods
3. Mindvalley_AssessmentTests - Testing the Collectionview with and without data.
4. Mindvalley_AssessmentUITests - Testing the Pull to refresh and UIApplication background and foreground.

