//
//  ViewController.swift
//  MyPreferences
//
//  Created by Charles Konkol on 3/23/15.
//  Copyright (c) 2015 Rock Valley College. All rights reserved.
//
import UIKit

class PrefsViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBAction func btnClear(sender: AnyObject) {
        
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(nil, forKey: "username")
        defaults.setObject(nil, forKey: "password")
        defaults.setObject(nil, forKey: "color")
        
        defaults.synchronize()
        
        txtUsername.text = ""
        txtPassword.text = ""
        MyColors.selectRow(0,inComponent: 0, animated: true)
        txtUsername.becomeFirstResponder()
        
    }
    
    //color
    var selectedcolor:String!
    let pickerColor = ["Black","Red","Orange", "Blue"]
    //    @IBAction func btnLoad(sender: UIButton) {
    //        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    //
    //        if let userNameNotNull = defaults.objectForKey("username") as? String {
    //            self.txtUsername.text = defaults.objectForKey("username") as? String
    //        }
    //
    //        if let passwordIsNotNill = defaults.objectForKey("password") as? String {
    //            self.txtPassword.text = defaults.objectForKey("password") as? String
    //        }
    //
    //
    //        if let colorIsNotNill = defaults.objectForKey("color") as? String {
    //            var favoriteColorSelected = defaults.objectForKey("color") as! String
    //            let SelectedColor:Int = (pickerColor).indexOf(favoriteColorSelected)!
    //
    //            if (favoriteColorSelected=="White")
    //            {
    //                self.view.backgroundColor = UIColor.whiteColor()
    //            }
    //            if (favoriteColorSelected=="Red")
    //            {
    //                self.view.backgroundColor = UIColor.redColor()
    //            }
    //            if (favoriteColorSelected=="Yellow")
    //            {
    //                self.view.backgroundColor = UIColor.yellowColor()
    //            }
    //            if (favoriteColorSelected=="Blue")
    //            {
    //                self.view.backgroundColor = UIColor.blueColor()
    //            }
    //
    //
    //            MyColors.selectRow(SelectedColor,inComponent: 0, animated: true)
    //        }
    //    }
    
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var MyColors: UIPickerView!
    
    
    @IBAction func btnSave(sender: UIButton) {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(self.txtUsername.text, forKey: "username")
        defaults.setObject(self.txtPassword.text, forKey: "password")
        defaults.setObject(selectedcolor, forKey: "color")
        
        
        defaults.synchronize()
    }
    
    @IBAction func backBtn(sender: UIBarButtonItem) {
         self.dismissViewControllerAnimated(false, completion: nil)
    }
    //Needed for picker
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerColor.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        selectedcolor=pickerColor[row]
        //        if (selectedcolor=="White")
        //        {
        //            self.view.backgroundColor = UIColor.whiteColor()
        //        }
        //        if (selectedcolor=="Red")
        //        {
        //            self.view.backgroundColor = UIColor.redColor()
        //        }
        //        if (selectedcolor=="Yellow")
        //        {
        //            self.view.backgroundColor = UIColor.yellowColor()
        //        }
        //        if (selectedcolor=="Blue")
        //        {
        //            self.view.backgroundColor = UIColor.blueColor()
        //        }
        //
        return pickerColor[row]
        
    }
    //new method hiding keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches , withEvent: event)
    }
    //set delegate to all uitextfields
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //txtUsername.becomeFirstResponder()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
