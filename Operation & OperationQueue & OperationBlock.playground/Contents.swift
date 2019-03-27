import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Operation and Operation Queue"

//print(Thread.current)

//let operation1 = {
//    print("Start in operation")
//    print(Thread.current)
//    print("Finish operation")
//}
//
//let queue = OperationQueue()
//queue.addOperation(operation1)

// ===

//print(Thread.current)
//
//var result: String?
//let concurrentOperation = BlockOperation {
//    print(Thread.current)
//    result = "The Swift" + " " + "Developers"
//    print("I'm here")
//}
//
//let queue = OperationQueue()
//
//queue.addOperation(concurrentOperation)
//sleep(2)
//print(result ?? "Not defined")

// ===

//let operationQueue1 = OperationQueue()
//let operationQueue2 = OperationQueue()
//
//var int = 1
//let operation = BlockOperation { print(int); int += 1 }
//
//operationQueue1.addOperation(operation)
//print(int)

// ===

//print(Thread.current)
//let queue1 = OperationQueue()
//queue1.addOperation {
//    print("test")
//    print(Thread.current)
//}

// ===

//print(Thread.current)
//
//class MyThread: Thread {
//    override func main() {
//        print("Test main thread")
//    }
//}
//
//let myThread = MyThread()
//myThread.start()

print(Thread.current)
class OperationA: Operation {
    override func main() {
        print("Test operation A")
        print(Thread.current)
    }
}

let operationA = OperationA()
//operationA.start()

let queue1 = OperationQueue()
queue1.addOperation(operationA)

