import XCTest

// Расширения, добавляющее методы для работы с элементами
extension XCUIElement {

    // MARK: Swipes and Scrolls
    /// Типы скролла
    enum ScrollType {
        case upperHalf, normal, bottomHalf, refresh, refreshWithBanners, up
    }

    /// Типы свайпа
    enum SwipeType {
        case left, right, leftGently
    }

    /// Типы тапа
    enum TapType {
        case center, rightHalf, leftHalf
    }

    /**
     Метод, совершающий скролл
     - parameter scrollType: Тип скролла, по умолчанию обычный
     */
    func gentleScroll(_ scrollType: ScrollType = .normal) {

        let half: CGFloat = 0.5
        let adjustment: CGFloat = 0.15

        let shortPressDuration: TimeInterval = 0.1
        let longPressDuration: TimeInterval = 0.3

        let lessThanHalf = half - adjustment
        let evenLesserThanHalf = half - adjustment * 2
        let moreThanHalf = half + adjustment
        let evenMoreThanHalf = half + adjustment * 2

        let centre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
        let aboveCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))
        let evenMoreAboveCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: evenLesserThanHalf))
        let belowCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
        let evenMoreBelowCentre = coordinate(withNormalizedOffset: CGVector(dx: half, dy: evenMoreThanHalf))

        switch scrollType {
        case .normal:
            centre.press(forDuration: shortPressDuration, thenDragTo: aboveCentre)
        case .upperHalf:
            aboveCentre.press(forDuration: shortPressDuration, thenDragTo: evenMoreAboveCentre)
        case .bottomHalf:
            belowCentre.press(forDuration: shortPressDuration, thenDragTo: centre)
        case .refresh:
            aboveCentre.press(forDuration: shortPressDuration, thenDragTo: evenMoreBelowCentre)
        case .refreshWithBanners:
            evenMoreAboveCentre.press(forDuration: longPressDuration, thenDragTo: evenMoreBelowCentre)
        case .up:
            aboveCentre.press(forDuration: shortPressDuration, thenDragTo: belowCentre)
        }
    }

    /**
     Метод автоматически скроллит вниз, пока искомый элемент не станет видимым
     - parameter element: Искомый элемент
     - parameter scrollType: Тип скролла, по умолчанию .normal
     - parameter maxCount: Максимальное кол-во скроллов, по умолчанию 10
     */
    @discardableResult
    func scrollToElement( _ element: XCUIElement, scrollType: ScrollType = .normal, maxScolls maxCount: Int = 10) -> XCUIElement {
        var count = 0
        while !element.isVisible() && count < maxCount {
            gentleScroll(scrollType)
            count += 1
        }
        if count == maxCount {
            XCTFail("Элемент не был найден после \(count) скроллов")
        }
        return element
    }

    /**
     Метод свайпает элемент в сторону
     - parameter element: Искомый элемент
     - parameter swipeType: Тип свайпа (e.g. .left)
     */
    func swipeElement( _ element: XCUIElement, swipeType: SwipeType) {

        let half: CGFloat = 0.5

        let rightOffset = CGVector(dx: 0.95, dy: 0.5)
        let leftOffset = CGVector(dx: 0.05, dy: 0.5)

        let elementFarRightCoordinate = element.coordinate(withNormalizedOffset: rightOffset)
        let elementFarLeftCoordinate = element.coordinate(withNormalizedOffset: leftOffset)
        let elementCentre = element.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))

        switch swipeType {
        case .left:
            elementFarRightCoordinate.press(forDuration: 0.1, thenDragTo: elementFarLeftCoordinate)
        case .right:
            elementFarLeftCoordinate.press(forDuration: 0.1, thenDragTo: elementFarRightCoordinate)
        case .leftGently:
            elementFarRightCoordinate.press(forDuration: 0.1, thenDragTo: elementCentre)
        }

    }

    // MARK: Taps and input
    /// Метод, производящий длительное нажатие на элемент
    func longTap(for time: Double = 10.0) {
        print("Long tap element \(self)")
        waitForElementToAppear(self, for: time)
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).press(forDuration: 1.0)
    }

    ///
    ////// Метод, производящий длительное нажатие на элемент
    func veryLongTap(for time: Double = 10.0) {
        print("Long tap element \(self)")
        waitForElementToAppear(self, for: time)
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).press(forDuration: time)
    }

    /// Метод тапает на элемент, если он появился на экране за время time
    func tapElement(for time: Double = 10.0, at destination: TapType = .center) {

        let rightOffset = CGVector(dx: 0.95, dy: 0.5)
        let leftOffset = CGVector(dx: 0.05, dy: 0.5)

        let elementFarRightCoordinate = self.coordinate(withNormalizedOffset: leftOffset)
        let elementFarLeftCoordinate = self.coordinate(withNormalizedOffset: rightOffset)

        print("Tap element \(self)")

        switch destination {
        case .center:
            print("Tap element \(self)")
            waitForElementToAppear(self, for: time).tap()
        case .leftHalf:
            waitForElementToAppear(self, for: time)
            elementFarLeftCoordinate.press(forDuration: 0.1)
        case .rightHalf:
            waitForElementToAppear(self, for: time)
            elementFarRightCoordinate.press(forDuration: 0.1)
        }

    }

    /**
     Метод стандартного введения текста в поле
     * * * *
     Метод ждем появление элемента, проверяет, что в указанном элементе есть поле, затем очищает его, и вводит указанный текст
     - parameter text: Вводимый текст
     - parameter time: Время ожидания
     */
    func typeIn(_ text: String, for time: Double = 10.0) {
        print("Typing \(text) into element \(self)")
        waitForElementToAppear(self, for: time)

        guard let stringValue = value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        tapElement()
        typeText(deleteString)
        typeText(text)
    }

    func deleteText() {
        waitForElementToAppear(self)
        guard let stringValue = value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        tapElement()
        typeText(deleteString)
    }

    // MARK: Element visibility, existance, labels methods
    /// Метод проверки видимости элемента
    func isVisible(willWaitFor timeout: Int = 5) -> Bool {
        guard waitForExistence(timeout: TimeInterval(timeout)) && !frame.isEmpty else { return false }
        print("Element visibility is \(XCUIApplication().windows.element(boundBy: 0).frame.contains(frame))")
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(frame)
    }

    /// Метод проверят что указанный элемент содержит label с текстом
    func elementContainsText(text: String, type: ElementType = .staticText) -> Bool {

        let predicate = NSPredicate(format: "label CONTAINS %@", text)
        guard self.isVisible() else { return false }
        return self.descendants(matching: type).matching(predicate).firstMatch.exists
    }

    /**
     Метод, ожидающий time секунд до появления элемента
     - parameter element: Искомый элемент
     - parameter notStrict: Если false, то при отсутствии элемента тест упадет, иначе выполнение продолжится. По умолчанию false
     - parameter time: Количество секунд ожидания. По умолчанию 10.
     */
    @discardableResult
    func waitForElementToAppear(
        _ element: XCUIElement,
        notStrict: Bool = false,
        for time: Double = 10.0
    ) -> XCUIElement {
        print("Waiting for element \(element) to appear...")
        let result: XCTWaiter.Result =
            XCTWaiter().wait(for: [XCTNSPredicateExpectation(predicate:
                NSPredicate(format: "exists == true"), object: element)], timeout: time)
        if !notStrict && result != .completed {
            // если строго требуем наличие элемента и условие не выполнилось
            XCTFail("Element with identifier '\(element.identifier)' didn't appear during \(time) secs")
        }
        return element
    }

    func assertButtonOnSegmentedControlIsSelected(name: String, selected: Bool = true) {
        XCTContext.runActivity(named: "Проверяет что выбран таб \(name)") { _ in
            let button = self.segmentedControls.buttons[name]
            XCTAssert(button.isSelected == selected)
        }
    }

    /**
     Метод, ожидающий time секунд до появления элемента
     - parameter name: Название свитча
     - parameter status: Если  true: то свитч активен: если false, то выключен
     - parameter order: порядковый номер свитча начиная с 0
     */
    func assertSwitchStatus(name: String = "", status: Bool = true, order: Int = 0) {
        XCTContext.runActivity(named: "Проверяет  включен ли Switch, ожидаемое значение \(status)")  { _ in
            var switcher: XCUIElement
            if name == "" {
                switcher = self.switches.element(boundBy: order)
            } else {
                switcher = self.switches[name]
            }
            if status == true {
                XCTAssertEqual(switcher.value.debugDescription, "Optional(1)")
            } else {
                XCTAssertEqual(switcher.value.debugDescription, "Optional(0)")
            }
        }
    }


    enum Languages {
        case ru, en
    }
    /**
     Метод, ожидающий time секунд до появления элемента
     - parameter expectedNum: Номер открытой страницы
     - parameter totalPages: Всего страниц
     - parameter lang: Язык текста label индикатора, дефолтное значение ru, может быть en
     */
    func assertPageNumberOnPageIndicator(expectedNum: String, totalPages: String, lang: Languages = .ru) {
        XCTContext.runActivity(named: "Проверяет номер открытой страницы. Ожидаемое значение \(expectedNum) из \(totalPages)") { _ in
            let pageIndicator = self.pageIndicators.element
            if lang == .ru {
                XCTAssertEqual(pageIndicator.value as? String, "страница \(expectedNum) из \(totalPages)")
            }
            else if lang == .en {
                XCTAssertEqual(pageIndicator.value as? String, "page \(expectedNum) of \(totalPages)")
            }
        }
    }

    func pressButtonOnSheet(name: String) {
        XCTContext.runActivity(named: "Нажимает на кнопку \(name) во всплывающем Меню действий") { _ in
            let button = self.sheets.otherElements.scrollViews.otherElements.buttons[name]
            waitForElementToAppear(button)
            button.tapElement()
        }
    }
}
