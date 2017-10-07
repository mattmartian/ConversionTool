/*
 I, Matthew Martin, student number 000338807, certify that this material is my original work.
No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.
 */




//  TemperatureViewController.swift
//  Converter
//
//  Created by Student on 2017-10-04.
//  Copyright © 2017 Mohawk College. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet var userTemp: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    
    
    //Immediatley convert the values when the value in enetered and the button is clicked
    var fromCelciusValue: Measurement<UnitTemperature>?{
        didSet{
            fahrenheitConversion()
        }
    }
    var fromFahrenheitValue: Measurement<UnitTemperature>?{
        didSet {
            celciusConversion()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        celciusConversion()
        fahrenheitConversion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //Format the number to hold 1 decimal place
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 1
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    
    
    //Only allow the textfield to except a value after 1 decimal place
    func textField(_ userTemp: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = userTemp.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
   
    
    
    //Method that does the conversion from Fahrenheit to Celcius
    var toCelsiusValue: Measurement<UnitTemperature>? {
        if let fromFahrenheitValue = fromFahrenheitValue {
            return fromFahrenheitValue.converted(to: .celsius)
        } else {
            return nil
        }
    }
    
    
    //Mathod that does the conversion from Celcius to Fahrenheit
    var toFahrenheitValue: Measurement<UnitTemperature>?{
        if let fromCelciusValue = fromCelciusValue {
            return fromCelciusValue.converted(to: .fahrenheit)
        }
        
        else {
            return nil
        }
    }
 

    //Display the result of the conversion to the user from fahrenheit to celcius
    func celciusConversion(){
        if let toCelsiusValue = toCelsiusValue {
            resultLabel.text = numberFormatter.string(from: NSNumber(value: Double(userTemp.text!)!))! + " ℉" + " is " + numberFormatter.string(from: NSNumber(value: toCelsiusValue.value))! + "℃"
        } else {
            resultLabel.text = " "
        }

    }
    
    //display the result of the conversion to the user from celcius to fahrenheit
    func fahrenheitConversion(){
        if let toFahrenheitValue = toFahrenheitValue {
            resultLabel.text = numberFormatter.string(from: NSNumber(value: Double(userTemp.text!)!))! + " ℃ " + " is " + numberFormatter.string(from: NSNumber(value: toFahrenheitValue.value))! + "℉"
        } else {
            resultLabel.text = " "
        }
    }
    
    
    
    //When the convert to celcius button is clicked, convert the users input from celcius to fahrenheit
    @IBAction func convertCelcius(_ sender: Any) {
        if let input = userTemp.text, let value = Double(input){
            fromCelciusValue = Measurement(value: value, unit: .celsius)
        } else{
            fromCelciusValue = nil
        
        }
        //if it is not proper input, display an error to the user
        if(toFahrenheitValue == nil){
            resultLabel.text = "Unable to Convert " + userTemp.text!
        }
        
    }
    
    //when the convert to fahrenheit button is clicked, convert the users input from fahrenheit to celcius
    @IBAction func convertFahrenheit(_ sender: Any) {
        if let input = userTemp.text, let value = Double(input) {
            fromFahrenheitValue = Measurement(value: value, unit: .fahrenheit)
        } else {
            fromFahrenheitValue = nil
        }
        //if it is not proper input, display an error to the user
        if(toCelsiusValue == nil){
            resultLabel.text = "Unable to Convert " + userTemp.text!
        }
    }
    
    
    //when the user clicks outside of the area of the keyboard, hide the keyboard
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        userTemp.resignFirstResponder()
    }


}

