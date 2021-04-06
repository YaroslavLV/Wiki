import XCTest

class ReadingPreferences: BasePage {
    
    private lazy var lightTheme = app.tables.cells.staticTexts["Light"]
    private lazy var sepiaTheme = app.tables.cells.staticTexts["Sepia"]
    private lazy var darkTheme = app.tables.cells.staticTexts["Dark"]
    private lazy var blackTheme = app.tables.cells.staticTexts["Black"]
    private lazy var checkmark = app.tables.cells.buttons["checkmark"]
    
    func changeAllThemes() {
        XCTContext.runActivity(named: "Меняет по очереди все темы с проверкой наличия галочки на выбранной теме") {_ in
            let themes = [lightTheme,sepiaTheme,darkTheme,blackTheme]
            for theme in themes {
                theme.tap()
                XCTAssertTrue(checkmark.isVisible())
            }
        }
    }
}
