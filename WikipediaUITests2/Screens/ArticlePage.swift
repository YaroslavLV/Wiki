import XCTest

class ArticlePage: BasePage {
    
    private lazy var navigationBarWiki = app.navigationBars["W"]
    private lazy var saveButton = app.toolbars.otherElements.buttons["Save for later"]
    
    
    func assertAvailabilityNavigationBarWiki() {
        XCTContext.runActivity(named: "Проверяет наличие панели навигации Wiki на экране  ") {_ in
            XCTAssertTrue(navigationBarWiki.isVisible())
        }
    }
    
    func assertFindText(_ article: String) {
        XCTContext.runActivity(named: "Проверяет совпадает ли статья с запросом ") {_ in
            let articleName = app.webViews.otherElements[article].staticTexts[article].firstMatch
            XCTAssertTrue(articleName.isVisible())
        }
    }
    
    func pressNavigationBarButton() {
        XCTContext.runActivity(named: "Тапает на навбар, чтоб вернуться на главный экран") {_ in
            navigationBarWiki.tapElement()
        }
    }
    
    func pressSaveButton() {
        XCTContext.runActivity(named: "Сохраняет статью в Saved") {_ in
            saveButton.tapElement()
        }
    }
}
