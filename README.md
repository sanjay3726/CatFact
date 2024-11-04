# CatFact iOS APP
Present randam image of the cat along with random cat fact
Features
Random Cat Facts: Fetches a random fact about cats.
Random Cat Images: Displays a random cat image.
Tap to Refresh: Tapping on the screen fetches a new fact and image.
Error Handling: Shows an alert message if fetching data fails.
Loading Indicator: Displays a loading indicator while fetching images.

Technologies and Architecture
Language: Swift
Architecture: MVVM (Model-View-ViewModel)
Unit Testing: XCTest, with CatViewModelTests for mocking responses
UI Testing: XCTest for testing view interactions and updates

Code Structure
1. CatViewController
The main view controller that manages the display of cat facts and images. It contains:

createUI(): Create UI the user interface, including UIImageView for cat images, UILabel for cat facts, and UIActivityIndicatorView for loading.
fetchCatContent(): Calls the ViewModel to fetch new cat content.
loadImage(from:): Loads and displays the fetched image URL with asynchronous handling.

2. CatViewModel
CatViewModel provides data and interacts with services to fetch cat facts and images. It includes:

fetchCatContent(): Fetches a new cat fact and image URL.
Closures: Provides closures for updating the fact, image, and error message on the view.

3. CatAPIService 
fetchCatImage(): Featch new Image of Cat
fetchCatFact(): Featch the new fact

4. MockCatViewModel
A mock ViewModel created for testing, which simulates fetching cat facts and images without calling the actual APIs.

Testing
The project includes unit and UI tests using XCTest.

Unit Tests
Located in CatViewControllerTests.swift, these tests verify:

Fact Display: Ensures factLabel updates with the correct cat fact.
Loading Indicator: Checks that the loading indicator is visible while an image is being fetched.
Error Handling: Confirms that an error alert is shown when data fetching fails.

Initial Display: Checks if the initial cat fact and image load successfully.
Tap to Refresh: Ensures tapping the screen fetches and displays new content.

Launching: On app launch, a random cat fact and image appear.

Refreshing Content: Tap anywhere on the screen to refresh with a new fact and image.

Error Handling: If an error occurs while fetching data, an alert message is shown to the user.

Dependencies

No third-party dependencies are used in this app. All network requests and image handling are done using native Swift and UIKit frameworks.

Future Improvements

Add Network Layer: Separate the networking logic to improve code reusability and testability.

Add UIComponent: Make seprate uicomponent and extension for reusable function like activity indicater, alert.

Enhance Error Handling: Provide more detailed error messages and retry options.

Caching: Add caching for images to avoid unnecessary network requests.
