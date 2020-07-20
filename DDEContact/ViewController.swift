//
//  ViewController.swift
//  DDEContact
//
//  Created by iljoo Chae on 7/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationStyle()
        view.backgroundColor = .white
        navigationItem.title = "Companies"
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
        //able to remove tableView seperator(line)
        //tableView.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: #selector(handleAddCompany))
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func setupNavigationStyle() {
        let lightRed = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = lightRed
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .red
        
        //fix bug for title in black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    @objc func handleAddCompany() {
        print("Adding compnay")
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8 //arbitrary
    }
    
}



