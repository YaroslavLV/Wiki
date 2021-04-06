import XCTest
import Foundation

class Springboard {
    
    let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
    let settings = XCUIApplication(bundleIdentifier: "com.apple.Preferences")
    
    
    /**
     Terminate and delete the app via springboard
     */
    func deleteMyApp() {
        XCUIApplication().terminate()
        
        // Resolve the query for the springboard rather than launching it
        springboard.activate()
        
        
        // Force delete the app from the springboard
        // Handle iOS 11 iPad 'duplication' of icons (one nested under "Home screen icons" and the other nested under "Multitasking Dock"
        let icon = springboard.otherElements["Home screen icons"].otherElements.icons["Wikipedia"]
        if icon.exists {
            let iconFrame = icon.frame
            let springboardFrame = springboard.frame
            icon.press(forDuration: 5)
            Thread.sleep(forTimeInterval: 0.6)
            // Tap the little "X" button at approximately where it is. The X is not exposed directly
            springboard.coordinate(withNormalizedOffset: CGVector(dx: ((iconFrame.minX + 3) / springboardFrame.maxX), dy:((iconFrame.minY + 3) / springboardFrame.maxY))).tap()
            // Wait some time for the animation end
            Thread.sleep(forTimeInterval: 0.6)
            
            
            springboard.buttons["Delete App"].firstMatch.tap()
            springboard.alerts.buttons["Delete"].firstMatch.tap()
            
            // Press home once make the icons stop wiggling
            XCUIDevice.shared.press(.home)
            // Press home again to go to the first page of the springboard
            XCUIDevice.shared.press(.home)
            // Wait some time for the animation end
            Thread.sleep(forTimeInterval: 0.1)
            
            // Handle iOS 11 iPad 'duplication' of icons (one nested under "Home screen icons" and the other nested under "Multitasking Dock"
            
        }
    }
}
