//
//  ViewController.swift
//  Haya Chat
//
//  Created by Ahmed on 11/9/18.
//  Copyright © 2018 Neon. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    @objc func handleLogout() {
        let loginController: LoginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
}

