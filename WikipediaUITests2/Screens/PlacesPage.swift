import XCTest

class PlacesPage: BasePage {
    
    private lazy var alertLocation = app.scrollViews.otherElements.staticTexts["Explore articles near your location by enabling Location Access"]
    private lazy var closeLocationButton = app.scrollViews.otherElements.buttons["Close"]
    private lazy var searchPlaces = app.searchFields["Search Places"]
    
    
    func closeAlertLocation() {
        XCTContext.runActivity(named: "Закрывает аллерт с предложением включить геолокацию") {_ in
            if alertLocation.isVisible() {
                closeLocationButton.tap()
            }
        }
    }
    
    func searchPlaces(_ places: String) {
        XCTContext.runActivity(named: "Вводит \(places) в поисковую строку") {_ in
            searchPlaces.tapElement()
            searchPlaces.typeIn(places)
        }
    }
    
    func pressFindPlaces(_ places: String) {
        XCTContext.runActivity(named: "Нажимает на найденное место") {_ in
            let places = app.otherElements.tables.cells.staticTexts[places]
            places.tapElement()
        }
    }
    
    func assertPlacesOnScreen(_ places: String) {
        XCTContext.runActivity(named: "Проверяет что отображается правильное место на карте") {_ in
            let places = app.otherElements[places]
            XCTAssertTrue(places.isVisible())
        }
    }
}
