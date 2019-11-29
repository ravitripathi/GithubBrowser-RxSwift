//
//  ViewController.swift
//  MVVM-RxSwift
//
//  Created by Ravi Tripathi on 27/11/19.
//  Copyright © 2019 Ravi Tripathi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    var textToPass: String?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTap(_ sender: UIButton) {
        if let text = textField.text?.trimmingCharacters(in: .whitespaces), !text.isEmpty {
            self.textToPass = text
            performSegue(withIdentifier: "launchLanding", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "launchLanding", let destination = segue.destination as?  ContainerViewController {
            User.current.login = self.textToPass
        }
    }
}

