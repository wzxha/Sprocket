import UIKit
import XCTest
@testable import Sprocket

class Tests: XCTestCase {
    
    enum State: Int, Stateable  {
        case getUp
        case eat
        case sleep
        
        var string: String {
            switch self {
            case .getUp:
                return "getUp"
            case .eat:
                return "eat"
            case .sleep:
                return "sleep"
            }
        }
    }
    
    let sprocket = Sprocket<State>(idle: .getUp)
    
    override func setUp() {
        super.setUp()

        sprocket.rules = [
            [.sleep] >>> .getUp,
            [.getUp] >>> .eat,
            [.eat]   >>> .sleep,
        ]
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
        let allStates = State.all
        
        assert(allStates == [.getUp, .eat, .sleep], "State.all: '\(allStates)' are't equal to '[.getUp, .eat, .sleep]'")
    }
    
    func testFlow() {
        var string = ""
        
        sprocket.before { (from, to) in
            string += "[Before] \(from.string) to \(to.string) "
        }
        
        sprocket.on { (from, to) in
            string += "[On] \(from.string) to \(to.string) "
        }
        
        sprocket.after { (from, to) in
            string += "[After] \(from.string) to \(to.string) "
        }
        
        sprocket.to(.eat)
        assert(string == "[Before] \(State.getUp.string) to \(State.eat.string) [On] \(State.getUp.string) to \(State.eat.string) ")
        
        string = ""
        sprocket.to(.sleep)
        assert(string == "[After] \(State.getUp.string) to \(State.eat.string) [Before] \(State.eat.string) to \(State.sleep.string) [On] \(State.eat.string) to \(State.sleep.string) ")
        
        string = ""
        sprocket.to(.getUp)
        assert(string == "[After] \(State.eat.string) to \(State.sleep.string) [Before] \(State.sleep.string) to \(State.getUp.string) [On] \(State.sleep.string) to \(State.getUp.string) ")
    }
    
    func testSingleFlow() {
        var string = ""
        
        sprocket.before(.getUp) { (from) in
            string += "[Before] \(from.string) to \(State.getUp.string) "
        }
        
        sprocket.on(.getUp) { (from) in
            string += "[On] \(from.string) to \(State.getUp.string) "
        }
        
        sprocket.after(.getUp) { (from) in
            string += "[After] \(from.string) to \(State.getUp.string) "
        }
        
        sprocket.before(.eat) { (from) in
            string += "[Before] \(from.string) to \(State.eat.string) "
        }
        
        sprocket.on(.eat) { (from) in
            string += "[On] \(from.string) to \(State.eat.string) "
        }
        
        sprocket.after(.eat) { (from) in
            string += "[After] \(from.string) to \(State.eat.string) "
        }
        
        sprocket.before(.sleep) { (from) in
            string += "[Before] \(from.string) to \(State.sleep.string) "
        }
        
        sprocket.on(.sleep) { (from) in
            string += "[On] \(from.string) to \(State.sleep.string) "
        }
        
        sprocket.after(.sleep) { (from) in
            string += "[After] \(from.string) to \(State.sleep.string) "
        }
        
        sprocket.to(.eat)
        assert(string == "[Before] \(State.getUp.string) to \(State.eat.string) [On] \(State.getUp.string) to \(State.eat.string) ")
        
        string = ""
        sprocket.to(.sleep)
        assert(string == "[After] \(State.getUp.string) to \(State.eat.string) [Before] \(State.eat.string) to \(State.sleep.string) [On] \(State.eat.string) to \(State.sleep.string) ")
        
        string = ""
        sprocket.to(.getUp)
        assert(string == "[After] \(State.eat.string) to \(State.sleep.string) [Before] \(State.sleep.string) to \(State.getUp.string) [On] \(State.sleep.string) to \(State.getUp.string) ")
    }
}
