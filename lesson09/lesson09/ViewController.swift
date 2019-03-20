//
//  ViewController.swift
//  lesson09
//
//  Created by Maksim Nosov on 20/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        afterBlock(seconds: 2, queue: .global()) {
//            print("Hello")
//            print(Thread.current)
//        }

//        afterBlock(seconds: 2) {
//            print("Hello")
//            self.showAlert()
//            print(Thread.current)
//        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "Hello", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    func afterBlock(seconds: Int, queue: DispatchQueue = DispatchQueue.global(), completion: @escaping () -> () ) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }

}

