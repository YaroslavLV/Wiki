import Foundation
import XCTest

class SearchText: BaseTest {
    
    func testTapOnSearchResult(){
        let searchText = "Vladimir Putin"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.setTextOnSearchWikipedia(searchText)
        explorePage.pressButtonOnSearchKeyboard()
        explorePage.tapFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.assertAvailabilityNavigationBarWiki()
    }
    
    func testDeleteArticleOnHistoryPage() {
        let searchText = "Steve Jobs"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.setTextOnSearchWikipedia(searchText)
        explorePage.pressButtonOnSearchKeyboard()
        explorePage.tapFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.pressNavigationBarButton()
        historyPage.openTab(named: .history)
        historyPage.assertTabIsSelected(named: .history)
        historyPage.deleteArticleOnHistorePage(searchText)
        historyPage.assertNonAvailabilityArticleAfterDelete(searchText)
    }
    func testCleanHistoryPage() {
        let searchText = "Bill Gates"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.setTextOnSearchWikipedia(searchText)
        explorePage.pressButtonOnSearchKeyboard()
        explorePage.tapFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.pressNavigationBarButton()
        historyPage.openTab(named: .history)
        historyPage.assertTabIsSelected(named: .history)
        historyPage.deleteAllArticlesOnHistorePage()
        historyPage.assertNoHistoryToShow()
    }
    
    func testAssertToSavedPage() {
        let searchText = "Jeff Bezos"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.setTextOnSearchWikipedia(searchText)
        explorePage.pressButtonOnSearchKeyboard()
        explorePage.tapFindText(searchText)
        articlePage.assertFindText(searchText)
        articlePage.pressSaveButton()
        articlePage.pressNavigationBarButton()
        historyPage.openTab(named: .saved)
        historyPage.assertTabIsSelected(named: .saved)
        savedPage.assertFindTextToSavedPage(searchText)
    }
}
