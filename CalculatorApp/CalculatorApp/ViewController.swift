//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Kori Vernon on 4/10/20.
//  Copyright © 2020 Kori Vernon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var holder: UIView!
    
    var firstNumber = 0
    var resultNumber = 0
    
    var currentOperations: Operation?
    
    enum Operation {
        case add, subtract, multiply, divide
    }
    
    private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.textAlignment = .right
        label.font = UIFont(name: "Helvetica", size: 70)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //
        setupNumberPad()

    }
    
    private func setupNumberPad() {
        let buttonSize: CGFloat = view.frame.size.width / 4
        
        let zeroB = UIButton(frame:CGRect(x:0,y:holder.frame.size.height-buttonSize,width: buttonSize*2, height: buttonSize))
        //holder is different than view... holder is centers.
        zeroB.setTitleColor(.black, for: .normal)
        zeroB.backgroundColor = .white
        zeroB.setTitle("0", for: .normal)
        zeroB.tag = 1
        holder.addSubview(zeroB)
        
        let decB = UIButton(frame:CGRect(x:buttonSize*CGFloat(2),y:holder.frame.size.height-buttonSize,width: buttonSize, height: buttonSize))
        //holder is different than view... holder is centers.
        decB.setTitleColor(.black, for: .normal)
        decB.backgroundColor = .white
        decB.setTitle(".", for: .normal)
        holder.addSubview(decB)
        
        
        let operators: [String] = ["=","+","-","*","/"]
        let topOp: [String] = ["last","mod","%"]
        
        //clearbutton
        let clearButton = UIButton(frame: CGRect(x:0, y: holder.frame.size.height-(buttonSize*5.5),width: view.frame.size.width,height:buttonSize/2))
        clearButton.setTitleColor(.black, for: .normal)
        clearButton.backgroundColor = .blue
        clearButton.setTitle("Clear All", for: .normal)
        holder.addSubview(clearButton)
        
        
        for x in 0..<3 {
            let topButton = UIButton(frame: CGRect(x:buttonSize*CGFloat(x),y:holder.frame.size.height-(buttonSize*5),width: buttonSize, height: buttonSize))
            topButton.setTitleColor(.blue, for: .normal)
            topButton.backgroundColor = .orange
            topButton.setTitle("\(topOp[x])", for: .normal)
            holder.addSubview(topButton)
        }
        //numbers 1,2,3
        for x in 0..<3 {
            let button = UIButton(frame:CGRect(x:buttonSize * CGFloat(x),y:holder.frame.size.height-(buttonSize*2),width: buttonSize,height:buttonSize))
                button.setTitleColor(.black, for: .normal)
                button.backgroundColor = .white
                button.setTitle("\(x+1)",for: .normal)
                holder.addSubview(button)
                button.tag = (x+2)
                button.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        }
        //numbers 4,5,6
        for x in 0..<3 {
            let button = UIButton(frame:CGRect(x:buttonSize * CGFloat(x), y:holder.frame.size.height-(buttonSize*3),width:buttonSize,height:buttonSize))
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.setTitle("\(x+4)", for: .normal)
            holder.addSubview(button)
            button.tag = (x+5)
            button.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        }
        //numbers 7,8,9
        for x in 0..<3 {
            let button = UIButton(frame: CGRect(x:buttonSize * CGFloat(x),y:holder.frame.size.height-(buttonSize*4),width:buttonSize,height:buttonSize))
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.setTitle("\(x+7)",for: .normal)
            holder.addSubview(button)
            button.tag = (x+8)
            button.addTarget(self, action: #selector(numberPressed(sender:)), for: .touchUpInside)
        }
        //operators
        for x in 0..<5 {
            let opButton = UIButton(frame: CGRect(x:buttonSize*CGFloat(3),y:holder.frame.size.height-(buttonSize*CGFloat(x+1)),width:buttonSize, height: buttonSize))
            opButton.setTitleColor(.red, for: .normal)
            opButton.backgroundColor = .gray
            opButton.setTitle("\(operators[x])",for: .normal)
            holder.addSubview(opButton)
            opButton.tag = (x+11)
            opButton.addTarget(self, action: #selector(operationPressed(sender:)), for: .touchUpInside)
        }
        
        resultLabel.frame = CGRect(x:-10,y: clearButton.frame.origin.y-90,width: view.frame.size.width, height: 100)
        holder.addSubview(resultLabel)
        
        // Actions
        clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside)
        
    }
    
    @objc func clearResult() {
        resultLabel.text = "0"
    }
    @objc func numberPressed( sender: UIButton) {
        let tag = sender.tag - 1
        
        if resultLabel.text == "0" {
            resultLabel.text = "\(tag)"
        }
        else if let text = resultLabel.text {
            resultLabel.text = "\(text)\(tag)"
        }
        else {
            
        }
    }
    
    @objc func operationPressed( sender: UIButton){
//        else if tag > 10 {
//            // ["=","+","-","*","/"]

        let tag = sender.tag - 1
        //var calcList : [String]
        
        
        if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
            firstNumber = value
            resultLabel.text = "0"
        }
        
            if tag == 11 {
                if let operation = currentOperations {
                    var secondNumber = 0
                    if let text = resultLabel.text, let value = Int(text){
                        secondNumber = value
                        //calcList.append(value)
                    }
                    switch operation {
                    case .add:
                        let result = firstNumber + secondNumber
                        resultLabel.text = "\(result)"
                        break
                    case .subtract:
                        let result = firstNumber - secondNumber
                        resultLabel.text = "\(result)"
                        break
                    case .multiply:
                        let result = firstNumber * secondNumber
                        resultLabel.text = "\(result)"
                        break
                    case .divide:
                        let result = firstNumber / secondNumber
                        resultLabel.text = "\(result)"
                        break
                    }
                }
        
            } else if tag == 12 {
                currentOperations = .add
                // return +
            } else if tag == 13 {
                currentOperations = .subtract
                //return -
            } else if tag == 14 {
                currentOperations = .multiply
                //return *
            } else if tag == 15 {
                currentOperations = .divide
                //return /
            }

        }
        

    
}

