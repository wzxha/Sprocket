//
//  Rule.swift
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

infix operator >>>: LogicalConjunctionPrecedence

public struct Rule<State: Stateable> {
    let state: State
    
    let allows: [State]
    
    public init(_ allows: [State], canTo state: State) {
        
        self.state = state
        self.allows = allows
    }
}

public func >>> <State: Stateable>(lhs: [State], rhs: State) -> Rule<State> {
    return Rule<State>(lhs, canTo: rhs)
}
