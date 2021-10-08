//
//  ViewController.swift
//  Assignment2
//
//  Created by OM SHELKE on 9/18/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorRectangle: UIView!

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    let userDefaults = UserDefaults()

    @IBAction func editDidEnd() {
        hideKeyboard()
    }
    
    @IBAction func donePressed() {
        editDidEnd()
    }
    
    func hideKeyboard() {
        userDefaults.setValue(redTextField.text, forKey: "storedRedValue")
        userDefaults.setValue(greenTextField.text, forKey: "storedGreenValue")
        userDefaults.setValue(blueTextField.text, forKey: "storedBlueValue")
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        hideKeyboard()
    }
    
    @IBAction func colorButton(_ sender: Any) {
        hideKeyboard()
        let redValue = CGFloat(Double(redTextField.text ?? "0") ?? 0) / 100
        let greenValue = CGFloat(Double(greenTextField.text ?? "0") ?? 0) / 100
        let blueValue = CGFloat(Double(blueTextField.text ?? "0") ?? 0) / 100
        
        UIView.animate(withDuration: 1, animations:{ self.colorRectangle.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
        }, completion: nil)
    }
    
    @IBAction func unwindToHomeVC(unwindSegue: UIStoryboardSegue){
        updateRectangle()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        updateRectangle()
    }
    
    func updateRectangle() {
        if let rValue = userDefaults.value(forKey: "storedRedValue") as? String { redTextField.text = rValue }
        if let gValue = userDefaults.value(forKey: "storedGreenValue") as? String { greenTextField.text = gValue }
        if let bValue = userDefaults.value(forKey: "storedBlueValue") as? String { blueTextField.text = bValue }
        colorButton(UIButton.self())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

