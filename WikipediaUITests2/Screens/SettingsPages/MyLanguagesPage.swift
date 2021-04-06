import XCTest
class MyLanguagesPage: BasePage {
    
    private lazy var addLanguageButton = app.tables.otherElements.buttons["Add another language"]
    private lazy var findLanguageField = app.otherElements.searchFields["Find language"]
    
    func pressAddLanguage() {
        XCTContext.runActivity(named: "Нажимает на кнопку добавления языка") {_ in
            addLanguageButton.tapElement()
        }
    }
    func setLanguageOnFieldText(_ language:String) {
        XCTContext.runActivity(named: "вводит язык в поисковую строку") {_ in
            let findLanguage = app.tables.cells.staticTexts[language]
            findLanguageField.tapElement()
            findLanguageField.typeIn(language)
            if !findLanguage.isVisible() {
                XCTFail("Язык уже добавлен или не найден в списке")
            }
        }
    }
    
    func pressFindLanguage(_ language: String) {
        XCTContext.runActivity(named: "Нажимает на найденный язык") {_ in
            let findLanguage = app.tables.cells.staticTexts[language]
            findLanguage.tapElement()
        }
    }
    
    func assertAvailabilityLanguage(_ language: String) {
        XCTContext.runActivity(named: "Проверяет, что язык добавился") {_ in
            let language = app.tables.cells.staticTexts[language]
            XCTAssertTrue(language.isVisible())
        }
    }
}
