import XCTest

class LogInPage: BasePage {
   
    private lazy var logInText = app.scrollViews.otherElements.staticTexts["Log in to your account"]
    private lazy var usernameField = app.scrollViews.otherElements.textFields["enter username"]
    private lazy var passwordField = app.scrollViews.otherElements.secureTextFields["enter password"]
    private lazy var logInButton = app.scrollViews.otherElements.buttons["Log in"]
    private lazy var accountNameMenu = app.tables.cells.staticTexts["Account"]
    private lazy var logOutButton = app.tables.cells.staticTexts["Log out"]
    private lazy var alertLogOutButton = app.alerts.scrollViews.otherElements.buttons["Log out"]
    private lazy var textAlert = app.otherElements.buttons["No, delete articles from device"]
    
    func setUsername(_ username: String) {
        XCTContext.runActivity(named: "Вводит имя пользователя \(username)") {_ in
            usernameField.tapElement()
            usernameField.typeIn(username)
        }
    }
    
    func setPassword(_ password: String) {
        XCTContext.runActivity(named: "Вводит пароль пользователя \(password)") {_ in
            passwordField.tapElement()
            passwordField.typeIn(password)
        }
    }
    
    func pressLogInButton() {
        XCTContext.runActivity(named: "Нажимает на Log in") {_ in
            logInButton.tapElement()
        }
    }
    
    func assertNameButton(_ accountName: String) {
        XCTContext.runActivity(named: "Проверяет что зашли под тем аккаунтом, который вводили") {_ in
            let accountName = app.tables.cells.staticTexts[accountName]
            XCTAssertTrue(accountName.isVisible())
        }
    }
    
    func pressLogOut() {
        XCTContext.runActivity(named: "Выходим из учетной записи") {_ in
            logOutButton.tapElement()
            alertLogOutButton.tapElement()
        }
    }
}
