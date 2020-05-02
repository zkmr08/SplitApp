//
//  ViewController.swift
//  SplitApp
//
//  Created by Marouf, Zakaria on 01/05/2020.
//  Copyright © 2020 Marouf, Zakaria. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //billTextField, zeroPct, tenPct, fifteenPct, splitNmb
    @IBOutlet weak var billextField: UITextField!
    @IBOutlet weak var zeroPct: UIButton!
    @IBOutlet weak var tenPct: UIButton!
    @IBOutlet weak var fifteenPct: UIButton!
    @IBOutlet weak var splitNmb: UILabel!
    
    var tip = 0.10
    var numberOfPeople = 2
    var billTotal = 0.0
    var finalResult = "0.0"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func tipPctHandler(_ sender: UIButton) {
        billextField.endEditing(true)
        zeroPct.isSelected = false
        tenPct.isSelected = false
        fifteenPct.isSelected = false
        sender.isSelected = true
        
        let buttonTitle = sender.currentTitle!
        let buttonTitleWithoutPercentSign = String(buttonTitle.dropLast())
        let buttonTitleAsNumber = Double(buttonTitleWithoutPercentSign)!
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperHandler(_ sender: UIStepper) {
        splitNmb.text = String(format: "%.0f", sender.value)
        numberOfPeople = Int(sender.value)
    }
    
    @IBAction func calculateHandler(_ sender: UIButton) {
        let bill = billextField.text!
        if bill != "" {
            billTotal = Double(bill)!
            let result = billTotal * (1 + tip) / Double(numberOfPeople)
            finalResult = String(format: "%.2f", result)
        }
        self.performSegue(withIdentifier: "proceedToResults", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "proceedToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.result = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.split = numberOfPeople
        }
    }
    
}

