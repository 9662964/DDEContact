//
//  CreateCompanyController.swift
//  DDEContact
//
//  Created by iljoo Chae on 7/20/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

extension UIViewController {
  
    func setupNavigationStyle() {
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.backgroundColor = UIColor.lightRed
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.tintColor = .white
        
        
        //fix bug for title in black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    
}

class CreateCompanycomtroller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightBlue
        setupNavigationStyle()
        
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(handleCancel))
        
    }
    
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
