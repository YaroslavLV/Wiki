import XCTest

class HistoryPage: BasePage {
    
    private lazy var clearButton = app.buttons["Clear"]
    private lazy var deleteArticleButton = app.cells.otherElements.buttons["swipe action delete"]
    private lazy var deleteAllButton = app.scrollViews.buttons["Yes, delete all"]
    private lazy var noHistoryToShowText = app.otherElements.staticTexts["No history to show"]
    private lazy var keepTrackText = app.otherElements.staticTexts["Keep track of what you've been reading here"]
    
    func deleteArticleOnHistorePage(_ article: String) {
        XCTContext.runActivity(named: "Удаляет статью из истории") {_ in
            let articleName = app.cells.otherElements.staticTexts[article]
            swipeElement(articleName, swipeType: .left)
            deleteArticleButton.tapElement()
        }
    }
    
    func deleteAllArticlesOnHistorePage() {
        XCTContext.runActivity(named: "Удаляет всю историю") {_ in
            guard clearButton.isEnabled else  {
                XCTFail("История уже пустая")
                return
            }
            clearButton.tapElement()
            deleteAllButton.tapElement()
        }
    }
    
    func assertNoHistoryToShow() {
        XCTContext.runActivity(named: "Проверяет, что история полностью очищена") {_ in
            XCTAssertTrue(noHistoryToShowText.isVisible())
            XCTAssertTrue(keepTrackText.isVisible())
        }
    }
    
    func assertNonAvailabilityArticleAfterDelete(_ article: String) {
        XCTContext.runActivity(named: "Проверяет, отсутствие статьи на странице после удаления") {_ in
            let articleName = app.collectionViews.cells.staticTexts[article]
            XCTAssertFalse(articleName.isVisible())
        }
    }
}
