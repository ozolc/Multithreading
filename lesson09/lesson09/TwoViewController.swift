//
//  TwoViewController.swift
//  lesson09
//
//  Created by Maksim Nosov on 20/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class TwoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        for i in 0...2000000 {
//            print(i)
//        }
        
//        let queue = DispatchQueue.global(qos: .utility)
//        queue.async {
//            DispatchQueue.concurrentPerform(iterations: 200000) {
//                print("\($0) times")
//                print(Thread.current)
//            }
//        }
        myInactiveQueue()
    }
    
    func myInactiveQueue() {
        let inactiveQueue = DispatchQueue(label: "My queue", attributes: [.concurrent, .initiallyInactive])
        
        inactiveQueue.async {
            print("Done.")
        }
        
        print("Hasn't started yet...")
        
        inactiveQueue.activate()
        print("Activated.")
        
        inactiveQueue.suspend()
        print("Suspended.")
        
        inactiveQueue.resume()
        
    }
    
}
