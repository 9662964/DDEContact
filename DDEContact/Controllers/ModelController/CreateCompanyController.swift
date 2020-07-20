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

protocol CreateCompanyViewControllerDelegate {
    func didAddCompany(company: Company)
}


class CreateCompanycontroller: UIViewController {
    
    //Not tightly coupled
    var delegate: CreateCompanyViewControllerDelegate?
    
//    var companiesViewController: CompaniesViewController?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        //enable autolayout
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    
    
    override func viewDidLoad() {
        
        setupUI()
        
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightBlue
        setupNavigationStyle()
        navigationItem.title = "Create Company"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action:#selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
	    }
    
    @objc private func handleSave() {
        print("Tying to save company")
        
        dismiss(animated: true) {
            guard let companyName = self.nameTextField.text else {return}
              let company = Company(name: companyName, founded: Date())
              
            self.delegate?.didAddCompany(company: company)
//            self.companiesViewController?.addCompany(company: company)
//            CompaniesViewController.shared.addCompany(company: company)
        }
        
        
  
    }
    
    
    
    private func setupUI() {
        let lightBlueBackgroundView = UIView()
        lightBlueBackgroundView.backgroundColor = UIColor.lightBlue
        lightBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lightBlueBackgroundView)
        lightBlueBackgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lightBlueBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lightBlueBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lightBlueBackgroundView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 16).isActive = true
//        nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //use following will cover till bottom
        //nameLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
        
    }
    
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
}
