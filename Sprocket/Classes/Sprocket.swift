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

private let Before = "before"
private let On = "on"
private let After = "after"

public class Sprocket<State: Stateable> {
    // from -> to
    public typealias Flow = (State, State) -> Void

    // from ->
    public typealias SingleFlow = (State) -> Void

    private var before: Flow?
    
    private var on: Flow?
    
    private var after: Flow?
    
    var current: State
    
    private var last: State?
    
    private let states: [State]
    
    private var flows: [Int: [String: SingleFlow]] = [:]
    
    public init(states: [State] = State.all, idle: State) {
        self.states = states
        current = idle
    }
    
    public var rules: [Rule<State>] = []
    
    public func before(_ flow: @escaping Flow) {
        before = flow
    }
    
    public func on(_ flow: @escaping Flow) {
        on = flow
    }
    
    public func after(_ flow: @escaping Flow) {
        after = flow
    }
    
    public func before(_ state: State, flow: @escaping SingleFlow) {
        set(singleFlow: flow, when: state, forKey: Before)
    }
    
    public func on(_ state: State, flow: @escaping SingleFlow) {
        set(singleFlow: flow, when: state, forKey: On)
    }
    
    public func after(_ state: State, flow: @escaping SingleFlow) {
        set(singleFlow: flow, when: state, forKey: After)
    }
    
    private func set(singleFlow: @escaping SingleFlow, when state: State, forKey key: String) {
        var flows: [String: SingleFlow]
        
        if let lastEvents = self.flows[state.rawValue] {
            
            flows = lastEvents
        } else {
            
            flows = [:]
        }
        
        flows[key] = singleFlow
        
        self.flows[state.rawValue] = flows
    }
    
    @discardableResult
    public func to(_ state: State) -> Bool {
        guard canTo(state) else {
            print("[Sprocket] ⚠️⚠️⚠️ \(current) can't to \(state)")
            return false
        }
        
        if let last = last {

            if let stateEvents = flows[current.rawValue],
               let afterStateEvent = stateEvents[After] {
                
                afterStateEvent(last)
            }
            
            if let after = after {
                after(last, current)
            }
        }
        
        if let stateEvents = flows[state.rawValue],
           let beforeStateEvent = stateEvents[Before] {
            
            beforeStateEvent(current)
        }
        
        if let before = before {
            before(current, state)
        }
        
        if let stateEvents = flows[state.rawValue],
           let onStateEvent = stateEvents[On] {
            
            onStateEvent(current)
        }
        
        if let on = on {
            on(current, state)
        }
        
        last = current
        current = state
        
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
