import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "WorkItem"

class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", attributes: .concurrent)
    
    func create() {
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Finish task")
        }
        
        queue.async(execute: workItem)
    }
}

//let dispatchWorkItem1 = DispatchWorkItem1()
//dispatchWorkItem1.create()

class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem2")
    
    func create() {
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 1")
        }
        
        queue.async {
            sleep(1)
            print(Thread.current)
            print("Task 2")
        }
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Started WorkItem task 3")
        }
        
        queue.async(execute: workItem)
        
        workItem.cancel()
    }
}

//let dispatchWorkItem2 = DispatchWorkItem2()
//dispatchWorkItem2.create()

var view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))

eiffelImage.backgroundColor = UIColor.yellow
eiffelImage.contentMode = .scaleAspectFit
view.addSubview(eiffelImage)

PlaygroundPage.current.liveView = view

let imageURL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!

// classic variant
func fetchImage1() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: imageURL) {
            DispatchQueue.main.async {
                eiffelImage.image = UIImage(data: data)
            }
        }
    }
}

//fetchImage1()

// Dispatch work item
func fetchImage2() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInteractive) {
        data = try? Data(contentsOf: imageURL)
        print(Thread.current)
    }
    
    queue.async(execute: workItem)
    
    workItem.notify(queue: DispatchQueue.main) {
        if let imageData = data {
            eiffelImage.image = UIImage(data: imageData)
        }
    }
}

//fetchImage2()

// URLSession
func fetchImage3() {
    let task = URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
        print(Thread.current)
        if let imageData = data {
            DispatchQueue.main.async {
                print(Thread.current)
                eiffelImage.image = UIImage(data: imageData)
            }
        }
    }
    task.resume()
}

fetchImage3()














