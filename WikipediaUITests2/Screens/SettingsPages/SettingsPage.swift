import XCTest

class SettingsPage: BasePage {
    
    private lazy var switchReports = app.tables.switches["Send usage reports"]
    
    func pressScreenMenuOnSettingsPage( _ screen: String) {
        XCTContext.runActivity(named: "Переходит на экран \(screen)"){_ in
            let screen = app.tables.cells.staticTexts[screen]
            screen.tapElement()
        }
    }
    
    func pressSwitchSendUsageReports() {
        XCTContext.runActivity(named: "Включаем отчеты об использовании"){_ in
            switchReports.tap()
            assertSwitchStatus(name: "Send usage reports", status: true)
        }
    }
}
