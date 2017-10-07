/*
I, Matthew Martin, student number 000338807, certify that this material is my original work.
No other person's work has been used without due acknowledgement and I have not made my work available to anyone else.
*/



//  DistanceViewController.swift
//  Converter
//
//  Created by Student on 2017-10-04.
//  Copyright © 2017 Mohawk College. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet var userDistance: UITextField!
    
    
    @IBOutlet var resultLabel: UILabel!
    
    
    
    //Immediatley convert the values when the value in enetered and the button is clicked
    var fromKilometerValue: Measurement<UnitLength>?{
        didSet{
            milesConversion()
        }
    }
    
    var fromMileValue: Measurement<UnitLength>?{
        didSet{
            kilometerConversion()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        milesConversion()
        kilometerConversion()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Dismiss the keyboard when the user taps outside of the keyboard area
    @IBAction func dismissKeyboard(_sender: UITapGestureRecognizer){
        userDistance.resignFirstResponder()
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
    func textField(_ userDistance: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let existingTextHasDecimalSeparator = userDistance.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    
    //Method that does the conversion from kilometers to miles
    var toMileValue: Measurement<UnitLength>?{
        if let fromKilometerValue = fromKilometerValue{
            return fromKilometerValue.converted(to: .miles)
        }
        else{
            return nil
        }
    }
    
    //method that does the conversion from miles to kilometers
    var toKilometerValue: Measurement<UnitLength>?{
        if let fromMileValue = fromMileValue{
            return fromMileValue.converted(to: .kilometers)
        }
        else{
            return nil
        }
    }
    
    //Display the result of the conversion to the user from kilometers to miles
    func milesConversion(){
        if let toMileValue = toMileValue {
            resultLabel.text = numberFormatter.string(from: NSNumber(value: Double(userDistance.text!)!))! + " km" + " is " + numberFormatter.string(from: NSNumber(value: toMileValue.value))! + " miles"
        }
    }
    
    //display the result of the conversion to the user from miles to kilometers
    
    func kilometerConversion(){
        if let toKilometerValue = toKilometerValue{
            resultLabel.text = numberFormatter.string(from: NSNumber(value: Double(userDistance.text!)!))! + " miles" + " is " + numberFormatter.string(from: NSNumber(value: toKilometerValue.value))! + " km"
        }
    }
    
    
    
    //when the convert to kilometers button is clicked, convert the users input from kilometers to miles
    
    @IBAction func convertKilometers(_ sender: Any) {
        if let input = userDistance.text, let value = Double(input) {
            fromKilometerValue = Measurement(value: value, unit: .kilometers)
        } else {
            fromKilometerValue = nil
        }
        //if it is not proper input, display an error to the user
        if(toMileValue == nil){
            resultLabel.text = "Unable to Convert " + userDistance.text!
        }
    }
    
    // when the convert to miles button is clicked convert the users input from miles to kilometers
    
    
    @IBAction func convertMiles(_ sender: Any) {
        if let input = userDistance.text, let value = Double(input) {
            fromMileValue = Measurement(value: value, unit: .miles)
        } else {
            fromMileValue = nil
        }
        //if it is not proper input, display an error to the user
        if(toKilometerValue == nil){
            resultLabel.text = "Unable to Convert " + userDistance.text!
        }

    }

    
}
