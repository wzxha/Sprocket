import UIKit
import XCTest
@testable import Sprocket

class Tests: XCTestCase {
    
    enum State: Int, Stateable  {
        case getUp
        case eat
        case sleep
    }
    
    let sprocket = Sprocket<State>(idle: .getUp)
    
    override func setUp() {
        super.setUp()

        sprocket.rules = [
            [.sleep] >>> .getUp,
            [.getUp] >>> .eat,
            [.eat]   >>> .sleep,
        ]

        sprocket.before { (current, from) in }

        sprocket.on { (current, from) in }

        sprocket.after { (current, from) in }
    }
    
    func testCurrentState() {
        assert(.getUp == sprocket.current, "idle will be GetUp")
    }
    
    func testRules() {
        let getUpToSleep = sprocket.to(.sleep)
        assert(false == getUpToSleep, "GetUp can't to Sleep, but it has gone")
        
        let getUpToEat = sprocket.to(.eat)
        assert(getUpToEat, "GetUp can to Eat, but it has not gone")
        
        let eatToSleep = sprocket.to(.sleep)
        assert(eatToSleep, "Eat can to Sleep, but it has not gone")
        
        let sleepToGetUp = sprocket.to(.getUp)
        assert(sleepToGetUp, "Sleep can to GetUp, but it has not gone")
    }
    
    func testEnumAllCases() {
        let allCases = State.allCases
        
        assert(allCases == [.getUp, .eat, .sleep], "State.allCases: '\(allCases)' are't equal to '[.getUp, .eat, .sleep]'")
    }
    
}
