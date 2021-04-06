import XCTest

class SavedPage: BasePage {
    
    func assertFindTextToSavedPage(_ article: String) {
        XCTContext.runActivity(named: "Проверяет совпадает ли сохраненная статья с запросом") {_ in
            let articleName = app.collectionViews.cells.staticTexts[article]
            XCTAssertTrue(articleName.isVisible())
        }
    }
}
