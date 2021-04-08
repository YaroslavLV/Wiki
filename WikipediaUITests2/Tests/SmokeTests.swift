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
        explorePage.assertTextOnPage("On this day")
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
        placesPage.assertPlacesOnScreen("Canada\nCountry in North America")
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
    
    func testAssertTextMenuOnSettingsPage() {
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.pressSettingsButton()
        explorePage.assertTextOnPage("Log in")
        explorePage.assertTextOnPage("Support Wikipedia")
        explorePage.assertTextOnPage("My languages")
        explorePage.assertTextOnPage("Search")
        explorePage.assertTextOnPage("Explore feed")
        explorePage.assertTextOnPage("Notifications")
        explorePage.assertTextOnPage("Reading preferences")
        explorePage.assertTextOnPage("Article storage and syncing")
        explorePage.assertTextOnPage("Reading list danger zone")
        explorePage.assertTextOnPage("Clear cached data")
        explorePage.assertTextOnPage("Privacy policy")
        explorePage.assertTextOnPage("Terms of Use")
        explorePage.assertTextOnPage("Send usage reports")
        explorePage.assertTextOnPage("Rate the app")
        explorePage.assertTextOnPage("Help and feedback")
        explorePage.assertTextOnPage("About the app")
    }
    
    func testAssetTabOnSavedPage() {
        explorePage.closeBannerBeforeOpeningWiki()
        savedPage.openTab(named: .saved)
        savedPage.assertTabIsSelected(named: .saved)
        savedPage.assertTabAllArticles()
        savedPage.assertTabReadingLists()
    }
    
    func testSearchTextOnSearchPage() {
        let searchText = "Moscow"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .search)
        explorePage.assertTabIsSelected(named: .search)
        explorePage.setTextOnSearchWikipedia(searchText)
        explorePage.pressButtonOnSearchKeyboard()
        explorePage.tapFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.pressNavigationBarButton()
    }
}
