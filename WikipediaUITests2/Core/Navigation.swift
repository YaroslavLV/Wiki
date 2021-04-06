import XCTest

// Раcширение с набором функций, доступных из любой части приложения, с любого экрана
extension XCUIApplication {
    /// Список кнопок таббара в авторизованной зоне
    enum TabBar: String {
        case explore = "Explore"
        case places = "Places"
        case saved = "Saved"
        case history = "History"
        case search = "Search"
    }

    /**
     Открываем вкладку на таббаре
     - parameter tabName: Название вкладки
     */
    func openTab(named tabName: TabBar) {
        XCTContext.runActivity(named: "Открывает вкладку \(tabName.rawValue) на таббаре") { _ in

            let tab = tabBars.buttons[tabName.rawValue]
            tab.tapElement()
        }
    }

    /**
     Проверяет что открыта вкладка на таббаре
     - parameter tabName: Название вкладки
     */
    func assertTabIsSelected(named tabName: TabBar) {
        XCTContext.runActivity(named: "Проверяет что открыта вкладка \(tabName.rawValue) на таббаре") { _ in

            let tab = tabBars.buttons[tabName.rawValue]
            XCTAssertTrue(tab.isSelected)
        }
    }

    /**
     Проверка содержимого Navigation Bar
     - parameter name: Ожидаемое название в Navigation Bar
     */
    func assertNavigationBar(is name: String, willWaitFor: Int = 5) {
        XCTContext.runActivity(named: "Проверка, что Navigation Bar содержит значение \(name)") { _ in
            XCTAssertTrue(self.navigationBars[name].isVisible(willWaitFor: willWaitFor), "Отображен экран \(self.navigationBars.firstMatch.identifier), ожидался \(name)")
        }
    }
  }
