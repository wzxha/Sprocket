//
//  ViewController.swift
//  Sprocket
//
//  Created by Wzxhaha on 09/21/2017.
//  Copyright (c) 2017 Wzxhaha. All rights reserved.
//

import UIKit
import Sprocket

class ViewController: UIViewController {

    enum State: Int, Stateable  {
        case getUp
        case eat
        case sleep
    }
    
    let sprocket = Sprocket<State>(idle: .getUp)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sprocket.rules = [
            [.sleep] >>> .getUp,
            [.getUp] >>> .eat,
            [.eat]   >>> .sleep,
        ]
        
        sprocket.before { (current, from) in
            switch (current, from) {
            case (.getUp, .sleep):
                print("[before] sleep to getUp")
            case (.eat, .getUp):
                print("[before] getUp to eat")
            case (.sleep, .eat):
                print("[before] eat to sleep")
            default: break
            }
        }
        
        sprocket.on { (current, from) in
            switch (current, from) {
            case (.getUp, .sleep):
                print("sleep to getUp")
            case (.eat, .getUp):
                print("getUp to eat")
            case (.sleep, .eat):
                print("eat to sleep")
            default: break
            }
        }
        
        sprocket.after { (current, from) in
            switch (current, from) {
            case (.getUp, .sleep):
                print("[after] sleep to getUp")
            case (.eat, .getUp):
                print("[after] getUp to to eat")
            case (.sleep, .eat):
                print("[after] eat to sleep")
            default: break
            }
        }
        
        sprocket.to(.eat)
        sprocket.to(.sleep)
        sprocket.to(.getUp)
    }
}

