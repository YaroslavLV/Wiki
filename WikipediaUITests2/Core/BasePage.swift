import Foundation
import XCTest

class BasePage: XCUIApplication {
    
    let app = XCUIApplication()
    private lazy var searchOnKeyboardButton = app.keyboards.buttons["search"]
    private lazy var searchRuOnKeyboardButton = app.keyboards.buttons["Найти"]
    private lazy var skipButton = app.buttons["Skip"]
    
    func assertToolbarText(_ pagename: String) {
        XCTContext.runActivity(named: "Проверяет, что открыли страницу \(pagename) ") {_ in
            let pageName = app.toolbars.otherElements.staticTexts[pagename]
            XCTAssertTrue(pageName.isVisible())
        }
    }
    
    func pressButtonOnSearchKeyboard() {
        XCTContext.runActivity(named: "Нажимает на кнопку search") {_ in
            if searchOnKeyboardButton.isVisible() {
                searchOnKeyboardButton.tapElement()
            } else {
                searchRuOnKeyboardButton.tapElement()
            }
        }
    }
    
    func tapFindText(_ searchText: String) {
        XCTContext.runActivity(named: "Нажимает на найденный текст") {_ in
            let findText = app.collectionViews.cells.otherElements.images.firstMatch
            findText.tapElement()
        }
    }
    
    func elementContainsText(_ text: String, _ type: ElementType = .staticText) -> Bool {
        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        guard self.exists else { return false }
        return self.descendants(matching: type).matching(predicate).firstMatch.waitForExistence(timeout: 5)
    }
    
    func closeBannerBeforeOpeningWiki() {
        if skipButton.isVisible() {
            skipButton.tapElement()
        }
    }
}
