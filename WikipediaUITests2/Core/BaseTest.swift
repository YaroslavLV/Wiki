import Foundation
import XCTest

class BaseTest: XCTestCase {
    
    let app = XCUIApplication()
    let explorePage = ExplorePage()
    let articlePage = ArticlePage()
    let historyPage = HistoryPage()
    let savedPage = SavedPage()
    let placesPage = PlacesPage()
    let settingsPage = SettingsPage()
    let aboutTheApp = AboutTheApp()
    let logInPage = LogInPage()
    let myLanguagesPage = MyLanguagesPage()
    let readingPreferences = ReadingPreferences()
    
    override func setUp() {
        app.launch()
        continueAfterFailure = true
    }
    
    override func tearDown() {
        
        Springboard().deleteMyApp()
    }
}
