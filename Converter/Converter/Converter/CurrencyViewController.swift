/*
 I, Matthew Martin, student number 000338807, certify that this material is my original work.
 No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.
 */

//  CurrencyViewController.swift
//  Converter
//
//  Created by Student on 2017-10-04.
//  Copyright © 2017 Mohawk College. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet var userAmount: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    let cadToUSDRate = 0.81
    
    let usdToCadRate = 1.25
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        americanConversion()
        canadianConversion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Immediatley convert the values when the value in enetered and the button is clicked
    var fromCanadianValue: Double?{
        didSet{
            americanConversion()
        }
    }
    var fromAmericanValue: Double?{
        didSet {
            canadianConversion()
        }
    }
    
    //Number formatter to format the numbers to two decimal places
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.minimumFractionDigits = 2
        nf.maximumFractionDigits = 2
        return nf
    }()
    
    
    
    //Only allow the textfield to except a value after  decimal place
    func textField(_ userAmount: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = userAmount.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    
    
    //Method that does the conversion from USD TO CAD
    var toCanadianValue: Double? {
        if let fromAmericanValue = fromAmericanValue {
            return fromAmericanValue * usdToCadRate
        } else {
            return nil
        }
    }
    
    
    //Mathod that does the conversion from CAD TO USD
    var toAmericanValue: Double?{
        if let fromCanadianValue = fromCanadianValue {
            return fromCanadianValue * cadToUSDRate
        }
        else {
           return nil
        }
    }
    
    
    //Display the result of the conversion to the user from USD TO CAD
    func canadianConversion(){
        if let toCanadianValue = toCanadianValue {
            resultLabel.text = numberFormatter.string(from: NSNumber(value: Double(userAmount.text!)!))! + "USD " + " is " + numberFormatter.string(from: NSNumber(value: toCanadianValue))! + " CAD"
        } else {
            resultLabel.text = " "
        }
        
    }
    
    //display the result of the conversion to the user from CAD TO USD
    func americanConversion(){
        if let toAmericanValue = toAmericanValue {
            resultLabel.text = numberFormatter.string(from: NSNumber(value: Double(userAmount.text!)!))! + " CAD " + " is " + numberFormatter.string(from: NSNumber(value: toAmericanValue))! + " USD"
        } else {
            resultLabel.text = " "
        }
    }
    

    
    
    //when the user clicks outside of the area of the keyboard, hide the keyboard
    @IBAction func dismissKeyboard(_sender: UITapGestureRecognizer){
        userAmount.resignFirstResponder()
    }
    
    

    
//When this button is clicked the program will conver the value in CAD to USD
    @IBAction func convertCAD(_ sender: Any) {
        if let input = userAmount.text, let value = Double(input){
            fromCanadianValue = value
        } else{
            fromCanadianValue = nil
            
        }
        //if the user puts improper input, display that it cannot be converted
        if(toAmericanValue == nil){
            resultLabel.text = "Unable to Convert " + userAmount.text!
        }
    }
    //When this button is clicked the program will conver the value in USD TO CAD
    @IBAction func convertUSD(_ sender: Any) {
        if let input = userAmount.text, let value = Double(input){
            fromAmericanValue = value
        } else{
            fromAmericanValue = nil
            
        }
        //if the user puts improper input, display that it cannot be converted

        if(toCanadianValue == nil){
            resultLabel.text = "Unable to Convert " + userAmount.text!
        }
    }

}

