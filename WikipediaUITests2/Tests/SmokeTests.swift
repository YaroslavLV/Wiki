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
}
