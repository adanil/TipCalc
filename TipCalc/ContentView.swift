//
//  ContentView.swift
//  TipCalc
//
//  Created by Даниил Автушко on 13.03.2021.
//

import SwiftUI

class ViewController: UIViewController{
    var money:Float = 0{
        didSet{
            moneyField.text =  "$\(money)"
            tip = money * Float(Float(tipPercent)/100)
            totalMoney = money + tip
            
        }
    }
    private var moneyField : UITextField = {
        let moneyField = UITextField(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/4))
        moneyField.backgroundColor = .white
        moneyField.translatesAutoresizingMaskIntoConstraints = false
        moneyField.font = UIFont.systemFont(ofSize: 65)
        moneyField.placeholder = "$0.00"
        moneyField.keyboardType = .decimalPad
        moneyField.addTarget(self, action: #selector(selectMoney), for: .editingDidBegin)
        moneyField.layer.masksToBounds = true
        return moneyField
    }()
    
    
    private var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.font = UIFont.systemFont(ofSize: 20, weight:.medium)
        tipLabel.translatesAutoresizingMaskIntoConstraints = false
        tipLabel.layer.masksToBounds = true
        return tipLabel
    }()
    
    private var tipPercent:Int = 15 {
        didSet{
            tipLabel.text = "Tip(\(tipPercent)%)"
            tip = money * Float(Float(tipPercent)/100)
            totalMoney = money + tip
        }
    }
    
    
    private var tipMoneyLabel: UILabel = {
        let tipMoneyLabel = UILabel()
        tipMoneyLabel.font = UIFont.systemFont(ofSize: 20, weight:.medium)
        tipMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        tipMoneyLabel.layer.masksToBounds = true
        return tipMoneyLabel
    }()
    
    private var tip:Float = 0 {
        didSet{
//            print(tip)
            tipMoneyLabel.text = String(format: "$%.2f",tip)
        }
    }
    
    private var totalLabel: UILabel = {
        let totalLabel = UILabel()
        totalLabel.text = "Total:"
        totalLabel.font = UIFont.systemFont(ofSize: 20, weight:.medium)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.layer.masksToBounds = true
        return totalLabel
    }()
    
    private var totalMoneyLabel: UILabel = {
        let totalMoneyLabel = UILabel()
        totalMoneyLabel.font = UIFont.systemFont(ofSize: 20, weight:.medium)
        totalMoneyLabel.translatesAutoresizingMaskIntoConstraints = false
        totalMoneyLabel.layer.masksToBounds = true
        return totalMoneyLabel
    }()
    
    private var totalMoney: Float = 0 {
        didSet{
            totalMoneyLabel.text = String(format:"$%.2f" ,totalMoney)
        }
    }
    
    private var percentTipSlider : UISlider = {
        let percentTipSlider = UISlider(frame:CGRect(x: UIScreen.main.bounds.width*0.05, y: UIScreen.main.bounds.height*0.5, width: UIScreen.main.bounds.width*0.9, height: 50))
        percentTipSlider.minimumValue = 0
        percentTipSlider.maximumValue = 100
        percentTipSlider.isContinuous = true
        percentTipSlider.tintColor = UIColor.red
        percentTipSlider.addTarget(self, action: #selector(tipSliderAction), for: .valueChanged)
//        percentTipSlider.translatesAutoresizingMaskIntoConstraints = false
//        percentTipSlider.layer.masksToBounds = true
        
        return percentTipSlider
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
                
        title = "Tip calculator"
        tipLabel.text = "Tip(\(tipPercent)%)"
        tipMoneyLabel.text = "$\(tip)"
        totalMoneyLabel.text = "$\(totalMoney)"
        percentTipSlider.value = 50
        
        view.addSubview(moneyField)
        view.addSubview(tipLabel)
        view.addSubview(tipMoneyLabel)
        view.addSubview(totalLabel)
        view.addSubview(totalMoneyLabel)
        view.addSubview(percentTipSlider)
        
        self.addDoneButtonOnKeyboard()
        
        NSLayoutConstraint.activate([
            moneyField.topAnchor.constraint(equalTo: view.topAnchor, constant: UIScreen.main.bounds.height * 0.2),
            moneyField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -UIScreen.main.bounds.width * 0.1),
            tipLabel.topAnchor.constraint(equalTo:moneyField.bottomAnchor,constant: 5),
            tipLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -UIScreen.main.bounds.width * 0.3),
            tipMoneyLabel.topAnchor.constraint(equalTo:moneyField.bottomAnchor,constant: 5),
            tipMoneyLabel.leftAnchor.constraint(equalTo: tipLabel.rightAnchor,constant: UIScreen.main.bounds.width * 0.05),
            
            totalLabel.topAnchor.constraint(equalTo:tipLabel.bottomAnchor,constant: 5),
            totalLabel.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -UIScreen.main.bounds.width * 0.3),
            
            totalMoneyLabel.topAnchor.constraint(equalTo:tipLabel.bottomAnchor,constant: 5),
            totalMoneyLabel.leftAnchor.constraint(equalTo: totalLabel.rightAnchor,constant: UIScreen.main.bounds.width * 0.05),
            
//            percentTipSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: 0),
//            percentTipSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 0)
        ])
        
        
    }
    func addDoneButtonOnKeyboard()
     {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x:0, y:0, width:320, height:50))
       doneToolbar.barStyle = .default
       
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "done", style: UIBarButtonItem.Style.done, target: self, action: Selector("enterMoney"))
       
       var items = [UIBarButtonItem]()
       items.append(flexSpace)
       items.append(done)
       
       doneToolbar.items = items
       doneToolbar.sizeToFit()
       
       self.moneyField.inputAccessoryView = doneToolbar
        
       
     }

    
    @objc func enterMoney(){
        money = Float(moneyField.text!) ?? 0
        moneyField.endEditing(true)
    }
    @objc func selectMoney(){
        moneyField.text = ""
    }
    
    @objc func tipSliderAction(){
        tipPercent = Int(percentTipSlider.value)
    }
}
