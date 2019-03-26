import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "GCD Dispatch Barrier"

//var array = [Int]()
//
//for i in 0...9 {
//    array.append(i)
//}
//
//print(array)
//print(array.count)

//var array = [Int]()
//
//DispatchQueue.concurrentPerform(iterations: 10) { (index) in
//    array.append(index)
//}
//
//print(array)
//print(array.count)

class SafeArray<T> {
    private var array = [T]()
    private let queue = DispatchQueue(label: "The Swift Developers")
    
    public func append(_ value: T) {
        queue.async(flags: .barrier) {
            print("Используемый поток в барьере", Thread.current)
            print(Thread.current)
            self.array.append(value)
        }
    }
    
    public var valueArray: [T] {
        var result = [T]()
        queue.sync() {
            result = self.array
        }
        return result
    }
}

var arraySafe = SafeArray<Int>()
DispatchQueue.concurrentPerform(iterations: 4) { (index) in
    print("Созданный в concurrentPerform поток", Thread.current)
    arraySafe.append(index)
}

print("arraySafe:", arraySafe.valueArray)
print("arraySafe count:", arraySafe.valueArray.count)
