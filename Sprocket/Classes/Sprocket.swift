//
//  Sprocket.swift
//  Sprocket
//
//  Created by WzxJiang on 17/9/21.
//  Copyright © 2017年 WzxJiang. All rights reserved.
//
//  https://github.com/Wzxhaha/Sprocket
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public class Sprocket<State: Stateable> {
    
    public typealias Event = (State, State) -> Void

    private var before: Event?
    
    private var on: Event?
    
    private var after: Event?
    
    public var current: State
    
    private var last: State?
    
    private let states: [State]
    
    public init(idle: State) {
        self.states = State.allCases
        current = idle
    }
    
    public var rules: [Rule<State>] = []
    
    public func before(_ event: Event?) {
        before = event
    }
    
    public func on(_ event: Event?) {
        on = event
    }
    
    public func after(_ event: Event?) {
        after = event
    }
    
    @discardableResult
    public func to(_ state: State) -> Bool {
        guard canTo(state) else {
            
            print("[Sprocket] \(current) can't to \(state)")
            return false
        }
        
        if let last = last,
           let after = after {
            
            after(current, last)
        }
        
        last = current
        current = state
        
        if let before = before {
            before(current, last!)
        }
        
        if let on = on {
            on(current, last!)
        }
        
        return true
    }
    
    func canTo(_ state: State) -> Bool {
        
        var canTo = false
        
        rules.forEach {
            if $0.state == state {
                canTo = $0.allows.contains(current)
            }
        }
        
        return canTo
    }
}
