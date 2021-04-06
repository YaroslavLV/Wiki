import XCTest

class Validation: BaseTest {
   
    func testLogInToWiki() {
        let username = "YaroslavLV"
        let password = "123456Zz"
        explorePage.closeBannerBeforeOpeningWiki()
        explorePage.openTab(named: .explore)
        explorePage.assertTabIsSelected(named: .explore)
        explorePage.pressSettingsButton()
        settingsPage.assertToolbarText("Settings")
        settingsPage.pressScreenMenuOnSettingsPage("Log in")
        logInPage.setUsername(username)
        logInPage.setPassword(password)
        logInPage.pressLogInButton()
        logInPage.assertNameButton(username)
        settingsPage.pressScreenMenuOnSettingsPage("Account")
        logInPage.pressLogOut()
        logInPage.assertNameButton("Log in")
    }
}
