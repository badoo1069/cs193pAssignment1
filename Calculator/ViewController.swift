//
//  ViewController.swift
//  Calculator
//
//  Created by Saurabh on 22/02/15.
//  Copyright (c) 2015 sasquatch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var history: UILabel!
    
    var userIsInTheMiddleOfTypingANumber = false
    var userHasPressedFirstPoint = false
    let pi = M_PI
   
//    @IBAction func writeHistory(sender: UIButton) {
//        if userIsInTheMiddleOfTypingANumber {
//            history.text = history.text! + sender.currentTitle!
//        }
//        else {
//            history.text = history.text! + " " + sender.currentTitle!
//        }
//    }
  
    @IBAction func clear(sender: UIButton) {
    }
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
             display.text = display.text! + digit
             history.text =  history.text! +  sender.currentTitle!
        }
        else {
            display.text = digit
            history.text =  history.text! + " " + sender.currentTitle!
            userIsInTheMiddleOfTypingANumber = true
        }
    }

    @IBAction func enterPoint(sender: UIButton) {
        if !userHasPressedFirstPoint {
            appendDigit(sender)
            userHasPressedFirstPoint = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        history.text =  history.text! + " " + sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        switch operation {
        case "×": performOperation {$0 * $1}
        case "÷": performOperation {$1 / $0}
        case "+": performOperation {$1 + $0}
        case "-": performOperation {$1 - $0}
        case "√": performOperation {sqrt($0)}
        case "sin": performOperation {sin($0)}
        case "cos": performOperation {cos($0)}
        case "π": performOperation()
        default: break
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandStack.count >= 2 {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation(operation: Double -> Double) {
        if operandStack.count >= 1 {
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    func performOperation() {
        displayValue = pi
        println(pi)
        enter()
    }
    
    var operandStack = Array<Double>()
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        userHasPressedFirstPoint = false
        operandStack.append(displayValue)
        println("\(operandStack)")
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

