//
//  TestViewController.swift
//  movies
//
//  Created by Jatin Menghani on 12/04/19.
//  Copyright © 2019 Jatin Menghani. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkNetworkConnection()
    }
    
    func checkNetworkConnection() {
        if !ConnectionController.shared.isReachable(reachability: ConnectionController.reachable!) {
            // TODO:- Add alert
            print("No Internet")
        }
    }
}

// 299537
