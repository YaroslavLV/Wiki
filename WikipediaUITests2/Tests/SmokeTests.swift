import XCTest

class SmokeTests: BaseTest {
    
    
    func testAssertExplorePage() {
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
    }
    
    func testAssertAllTabs() {
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.openTab(named: .places)
        placesPage.closeAlertLocation()
        explorePage.assertTabIsSelected(named: .places)
        explorePage.openTab(named: .saved)
        explorePage.assertTabIsSelected(named: .saved)
        explorePage.openTab(named: .history)
        explorePage.assertTabIsSelected(named: .history)
        explorePage.openTab(named: .search)
        explorePage.assertTabIsSelected(named: .search)
    }
    
    func testAssertContentsOnExplorePage() {
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTextOnPage("Picture of the day")
        explorePage.assertTextOnPage("In the news")
        explorePage.assertTextOnPage("Random article")
        explorePage.assertTextOnPage("Yesterday")
    }
    
    func testSearchingText() {
        let searchText = "Apple"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.setTextOnSearchWikipedia(searchText)
        explorePage.pressButtonOnSearchKeyboard()
        explorePage.tapFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.assertAvailabilityNavigationBarWiki()
    }
    
    func testFindPlaces() {
        let places = "Canada"
        explorePage.closeBannerBeforeOpeningWiki()
        placesPage.openTab(named: .places)
        placesPage.closeAlertLocation()
        placesPage.assertTabIsSelected(named: .places)
        placesPage.searchPlaces(places)
        placesPage.pressFindPlaces(places)
        placesPage.assertPlacesOnScreen(places)
    }
    
    func testAssertVersionApp() {
        let version = "6.8.0 (0)"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.pressSettingsButton()
        settingsPage.pressScreenMenuOnSettingsPage("About the app")
        settingsPage.assertNavigationBar(is: "About")

        let versionInApp = aboutTheApp.getVersionApp()
        XCTAssertTrue(version == versionInApp, "Версии не совпадают")
    }
}
