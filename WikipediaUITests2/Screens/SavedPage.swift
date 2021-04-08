import XCTest

class SavedPage: BasePage {
    
    private lazy var allArticlesTab = app.otherElements.staticTexts["All articles"]
    private lazy var readingListsTab = app.otherElements.staticTexts["Reading lists"]
    private lazy var textNoSavedPagesYet = app.otherElements.staticTexts["No saved pages yet"]
    private lazy var textReadingLists = app.otherElements.staticTexts["Organize saved articles with reading lists"]
    
    func assertFindTextToSavedPage(_ article: String) {
        XCTContext.runActivity(named: "Проверяет совпадает ли сохраненная статья с запросом") {_ in
            let articleName = app.collectionViews.cells.staticTexts[article]
            XCTAssertTrue(articleName.isVisible())
        }
    }
    func assertTabAllArticles() {
        XCTContext.runActivity(named: "Проверяет что вкладка All articles выбрана и присутствует текст ") {_ in
            allArticlesTab.isSelected
            XCTAssertTrue(allArticlesTab.isVisible())
            XCTAssertTrue(textNoSavedPagesYet.isVisible())
        }
    }
    func assertTabReadingLists() {
        XCTContext.runActivity(named: "Проверяет что вкладка Reading lists выбрана и присутствует текст") {_ in
            readingListsTab.tap()
            readingListsTab.isSelected
            XCTAssertTrue(readingListsTab.isVisible())
            XCTAssertTrue(textReadingLists.isVisible())
        }
    }
}
