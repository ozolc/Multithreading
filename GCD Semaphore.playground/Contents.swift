import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "GCD Semaphore"

//let queue = DispatchQueue(label: "The Swift Developer", attributes: .concurrent)
//
//let semaphore = DispatchSemaphore(value: 0)
//
//queue.async {
//    semaphore.wait() // -1
//    sleep(3)
//    print("method 1")
//    semaphore.signal() // +1
//}
//
//queue.async {
//    semaphore.wait() // -1
//    sleep(3)
//    print("method 2")
//    semaphore.signal() // +1
//}
//
//queue.async {
//    semaphore.wait() // -1
//    sleep(3)
//    print("method 3")
//    semaphore.signal() // +1
//}
//
//let sem = DispatchSemaphore(value: 2)
//
//DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
//    sem.wait(timeout: DispatchTime.distantFuture)
//    sleep(1)
//    print("Block ", String(id))
//
//    sem.signal()
//}

class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 2)
    private var array = [Int]()
    
    private func methodWork(_ id: Int) {
        semaphore.wait() // -1
        
        array.append(id)
        print("test array", array.count)
        
        Thread.sleep(forTimeInterval: 1)
        semaphore.signal() // + 1
    }
    
    func startAllThreads() {
        DispatchQueue.global().async {
            self.methodWork(111)
        }
        DispatchQueue.global().async {
            self.methodWork(222)
        }
        DispatchQueue.global().async {
            self.methodWork(333)
        }
        DispatchQueue.global().async {
            self.methodWork(444)
        }
    }
}

let semaphoreTest = SemaphoreTest()
semaphoreTest.startAllThreads()

