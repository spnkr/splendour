/* The MIT License (MIT)
 *
 * Copyright (c) 2014 Marc Ransome
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Darwin
import Foundation

extension Int {
    static func random(range: Range<Int>) -> Int {
        return Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
    }

    static func random(max: Int) -> Int {
        return Int.random(0...max)
    }

    static func random(max: Int, count: Int) -> [Int] {
        var numbers = [Int]()
        for _ in 0..<count {
            numbers.append(Int.random(0...max))
        }
        return numbers
    }

    static func random(range: Range<Int>, count: Int) -> [Int] {
        var numbers = [Int]()
        for _ in 0..<count {
            numbers.append(Int.random(range))
        }
        return numbers
    }

    static func series(range: Range<Int>) -> [Int] {
        var numbers: [Int] = []
        for i in range {
            numbers.append(i)
        }
        return numbers
    }
    
    func to(max: Int, repeat: (index: Int) -> ()) {
        if (max > self) {
            for i in self...max {
                repeat(index: i)
            }
        }
        else {
            for i in reverse(max...self) {
                repeat(index: i)
            }
        }
    }

    func divisibleBy(other: Int) -> Bool {
        return (self % other == 0)
    }

    var even: Bool {
        return self % 2 == 0
    }

    var odd: Bool {
        return self % 2 != 0
    }
}

extension Array {
    func each(repeat: (value: T) -> ()) {
        for v in self {
            repeat(value: v)
        }
    }

    func random(count: Int) -> [T] {
        var randomElements = [T]()
        var selfRange = 0...(self.count - 1)

        for _ in 0..<count {
            randomElements.append(self[Int.random(selfRange)])
        }

        return randomElements
    }

    func random(count: Int, unique: Bool) -> [T] {
        let selfRange = 0..<self.endIndex
        var remainingIndices = Int.series(selfRange)
        var randomElements = [T]()
        
        if unique {
            for _ in 0..<count {

                if remainingIndices.count == 0 {
                    break
                }

                let rangeOfIndices = 0..<remainingIndices.endIndex
                let randomIndex = Int.random(rangeOfIndices)
                let randomValue = remainingIndices[randomIndex]

                randomElements.append(self[randomValue])
                remainingIndices.removeAtIndex(randomIndex)
            }
        }
        else {
            for _ in 0..<count {
                randomElements.append(self[Int.random(selfRange)])
            }
        }

        return randomElements
    }
}

func * (left: Int, right: String) -> String {
    var concatenation = ""
    for _ in 0..<left {
        concatenation += right
    }
    return concatenation
}

func * (left: String, right: Int) -> String {
    return right * left
}

func / (left: String, right: String) -> [String] {
    return left.componentsSeparatedByString(right)
}
