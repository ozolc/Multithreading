import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

var str = "Dispatch Group"

class DispatchGroupTest1 {
    private let queueSerial = DispatchQueue(label: "The Swift Developers")
    
    private let groupRed = DispatchGroup()
    
    func loadInfo() {
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("1")
        }
        
        queueSerial.async(group: groupRed) {
            sleep(1)
            print("2")
        }
        
        groupRed.notify(queue: .main) {
            print("groupRed has finished.")
        }
    }
}

let dispatchGroupTest1 = DispatchGroupTest1()
//dispatchGroupTest1.loadInfo()

class DispatchGroupTest2 {
    private let queueConc = DispatchQueue(label: "The Swift Developers", attributes: .concurrent)
    
    private let groupBlack = DispatchGroup()
    
    func loadInfo() {
        groupBlack.enter()
        queueConc.async {
            sleep(1)
            print("1")
            self.groupBlack.leave()
        }
        
        groupBlack.enter()
        queueConc.async {
            sleep(1)
            print("2")
            self.groupBlack.leave()
        }
        
        groupBlack.wait()
        print("All queues have finished")
        
        groupBlack.notify(queue: .main) {
            print("groupBlack has finished")
        }
    }
        
}

let dispatchGroupTest2 = DispatchGroupTest2()
//dispatchGroupTest2.loadInfo()

class EightImage: UIView {
    public var ivs = [UIImageView]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)))
        
        ivs.append(UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        ivs.append(UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)))
        
        for i in 0...7 {
            ivs[i].contentMode = .scaleAspectFit
            self.addSubview(ivs[i])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

var view = EightImage(frame: CGRect(x: 0, y: 0, width: 700, height: 900))
view.backgroundColor = UIColor.red

let imageURLs = ["https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
                 "https://adriatic-lines.com/wp-content/uploads/2015/04/canal-of-Venice.jpg",
                 "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
                 "http://www.picture-newsletter.com/arctic/arctic-12.jpg"
]

var images = [UIImage]()

PlaygroundPage.current.liveView = view

func asyncLoadImage(imageURL: URL,
                    runQueue: DispatchQueue,
                    completionQueue: DispatchQueue,
                    completion: @escaping (UIImage?, Error?) -> ()) {
    runQueue.async {
        do {
            let data = try Data(contentsOf: imageURL)
            completionQueue.async {
                completion(UIImage(data: data), nil)
            }
        } catch let error {
            completionQueue.async {
                completion(nil, error)
            }
        }
    }
}

func asyncGroup() {
    let aGroup = DispatchGroup()
    
    for (_, value) in imageURLs.enumerated() {
        aGroup.enter()
        guard let url = URL(string: value) else { return }
        asyncLoadImage(imageURL: url,
                       runQueue: .global(),
                       completionQueue: .main) { (image, error) in
                        guard let image = image else { return }
                        images.append(image)
                        aGroup.leave()
        }
    }
    
    aGroup.notify(queue: .main) {
        for (key, _) in imageURLs.enumerated() {
            view.ivs[key].image = images[key]
        }
    }
}

//asyncGroup()

func asyncURLSession() {
    for i in 0..<imageURLs.count {
        guard let url = URL(string: imageURLs[i]) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { return }
                view.ivs[i].image = UIImage(data: data)
            }
        }
        task.resume()
    }
}

asyncURLSession()
