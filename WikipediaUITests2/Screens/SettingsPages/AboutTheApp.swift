import XCTest

class AboutTheApp: BasePage {
    
    private lazy var screenAboutTheApp = app.tables.cells.staticTexts["About the app"]
    
    func  getVersionApp() -> String {
        XCTContext.runActivity(named: "Проверяет версию приложения") { _ in
            let version = app.webViews.element(boundBy: 2).otherElements.element(boundBy: 5).staticTexts.element(boundBy: 0).label
            return version
        }
    }
}
