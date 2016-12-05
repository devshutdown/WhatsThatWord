//
//  ViewController.swift
//  MyWordss
//
//  Created by Charles Konkol on 2016-05-05
//  Copyright © 2016 Chuck Konkol. All rights reserved.
//

import UIKit
//0) Add import for CoreData
import CoreData
import AVFoundation
import Darwin


class ViewController: UIViewController {
    var correctChoice = ""
    var use: [String] = []
    var correctScore = 0
    var incorrentScore = 0
    var attempts = 0
    
    @IBAction func addWord(sender: UIButton) {
    }
    @IBOutlet weak var kwords: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBAction func btnSave(sender: AnyObject) {
        
        //1 Add Save Logic
        
        //**Begin Copy**
        if (wordsdb != nil)
        {
            
            wordsdb.setValue(kwords.text, forKey: "kwords")
            
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entityForName("Words",inManagedObjectContext: managedObjectContext)
            
            let words = Words(entity: entityDescription!,
                                insertIntoManagedObjectContext: managedObjectContext)
            
            words.kwords = kwords.text!
            
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            status.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
            
        }
        //**End Copy**
    }
    
    @IBAction func btnBack(sender: AnyObject) {
        //2) Dismiss ViewController
        
        //**Begin Copy**
        self.dismissViewControllerAnimated(false, completion: nil)
        //**End Copy**
    }
    
    
    @IBAction func exitBtn(sender: UIButton) {
        exit(0)
    }
    
    //3) Add ManagedObject Data Context
    
    //**Begin Copy**
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //**End Copy**
    
    //4) Add variable wordsdb (used from UITableView
    
    //**Begin Copy**
    var wordsdb:NSManagedObject!
    //**End Copy**
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //5 Add logic to load db. If wordsdb has content that means a row was tapped on UiTableView
        
        //**Begin Copy**
        if (wordsdb != nil)
        {
            kwords.text = wordsdb.valueForKey("kwords") as? String
            
            btnSave.setTitle("Update", forState: UIControlState.Normal)
        }
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //**End Copy**
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //6 Add to hide keyboard
    
    //**Begin Copy**
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesBegan(touches , withEvent:event)
//        if (touches.first as UITouch!) != nil {
//            DismissKeyboard()
//        }
//    }
    //new method hiding keyboard
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches , withEvent: event)
    }
    //**End Copy**
    
    //7 Add to hide keyboard
    
    //**Begin Copy**
    func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        kwords.endEditing(true)
        
        
    }
    //**End Copy**
    
    //8 Add to hide keyboard
    
    //**Begin Copy**
    func textFieldShouldReturn(textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    //**End Copy**
    
    //Begin App
    
    
    
    
    @IBAction func uleftBtn(sender: UIButton) {
        
        check(uleftLbl.text!)
                
    }
    @IBOutlet weak var uleftLbl: UILabel!
    @IBAction func urightBtn(sender: UIButton) {
        
        check(urightLbl.text!)
        
    }
    @IBOutlet weak var urightLbl: UILabel!
    @IBAction func bleftBtn(sender: UIButton) {
        check(bleftLbl.text!)
        
    }
    @IBOutlet weak var bleftLbl: UILabel!
    
    @IBAction func brightBtn(sender: UIButton) {
        check(brightLbl.text!)
        
    }
    @IBOutlet weak var brightLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    @IBOutlet weak var attemptsLbl: UILabel!
    @IBAction func goBtn(sender: UIButton) {
        startGameCD()
    }
    
    
    func randomize(results: [AnyObject]) -> [String] {
        var useRandom: [String] = []
        var counter = 0
        
        while counter < 4 {
            
            
            let randomIndex = Int(arc4random_uniform(UInt32(results.count)))

            let person = results[randomIndex] as! NSManagedObject
              
             let first = person.valueForKey("kwords")
            
            if useRandom.contains(first! as! String){
                
            }
            else{
                useRandom.append(first! as! String)
                counter += 1
            }
        }
        
        uleftLbl.text = useRandom[0]
        urightLbl.text = useRandom[1]
        bleftLbl.text = useRandom[2]
        brightLbl.text = useRandom[3]
        
        return useRandom;
    }
    
    
    
    func wordPrompt(use: [String]) -> Int {
        
        let voiceToUse = AVSpeechSynthesisVoice(identifier: AVSpeechSynthesisVoiceIdentifierAlex)
        
        let synth = AVSpeechSynthesizer()
        var correct = 0
        correct = Int(arc4random_uniform(UInt32(use.count)))
        
        var myUtterance = AVSpeechUtterance(string: "Choose the word" )
        myUtterance.voice = voiceToUse
        myUtterance.rate = 0.4
        synth.speakUtterance(myUtterance)
        myUtterance = AVSpeechUtterance(string: use[correct])
        myUtterance.rate = 0.3
        synth.speakUtterance(myUtterance)
        //+ "  "  + (use[correct])
        return correct;
    }
    
    func correct(choice: Int) -> Bool {
        let correct = false
        return correct;
    }
    
    func check(label: String) -> Void {
        if correctChoice == label
        {
            if attempts < 10
            {
            let synth = AVSpeechSynthesizer()
            let myUtterance = AVSpeechUtterance(string: "Great job!")
            myUtterance.rate = 0.5
            synth.speakUtterance(myUtterance)
            clearLabels()
            correctScore += 1
            scoreLbl.text = String(correctScore * 5)
            attempts += 1
            attemptsLbl.text = String(attempts) + " out of 10"
            }
            else{
                attemptsLbl.text = "Start Over!"
            }

        }
        else{
            
            if attempts < 10 {
            
            let synth = AVSpeechSynthesizer()
            let myUtterance = AVSpeechUtterance(string: "Oops. Try it again.")
            myUtterance.rate = 0.5
            synth.speakUtterance(myUtterance)
            incorrentScore += 1
            attempts += 1
            attemptsLbl.text = String(attempts) + " out of 10"
  
            }
            else{
                attemptsLbl.text = "Start Over!"
            }
        }
    }
    
    func startGame() -> Void {
        let results: [String] = ["the", "of", "to", "you", "she", "my", "is", "are", "do", "does"]
        use = randomize(results)
        correctChoice = use[wordPrompt(use)]
    }
    
    func startGameCD() -> Void {
        
        
        // Initialize Fetch Request
        let fetchRequest = NSFetchRequest()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entityForName("Words", inManagedObjectContext: self.managedObjectContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
            do
            {
                let results = try self.managedObjectContext.executeFetchRequest(fetchRequest)
                use = randomize(results)
                correctChoice = use[wordPrompt(use)]
            }
            catch {
                let fetchError = error as NSError
                print(fetchError)
            }

    }
    //    func restartGame() -> Void {
    //        use = randomize(results)
    //        correctChoice = use[wordPrompt(use)]    }
    
    func clearLabels() -> Void {
        uleftLbl.text = ""
        urightLbl.text = ""
        bleftLbl.text = ""
        brightLbl.text = ""
    }
    

}

