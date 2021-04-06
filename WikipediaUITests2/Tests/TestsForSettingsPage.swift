import XCTest
class TestsForSettingsPage: BaseTest {
    
    func testAddLanguage() {
        let language = "Ukrainian"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.pressSettingsButton()
        settingsPage.pressScreenMenuOnSettingsPage("My languages")
        myLanguagesPage.assertNavigationBar(is: "Wikipedia languages")
        myLanguagesPage.pressAddLanguage()
        myLanguagesPage.setLanguageOnFieldText(language)
        myLanguagesPage.pressFindLanguage(language)
        myLanguagesPage.assertAvailabilityLanguage(language)
    }
    func testChangeAllThemes() {
        let navBarNameAndScreenName = "Reading preferences"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.pressSettingsButton()
        settingsPage.pressScreenMenuOnSettingsPage(navBarNameAndScreenName)
        settingsPage.assertNavigationBar(is: navBarNameAndScreenName)
        readingPreferences.changeAllThemes()
    }
    
    func testPressSwitchSendUsageReports() {
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.pressSettingsButton()
        settingsPage.pressSwitchSendUsageReports()
    }
}
