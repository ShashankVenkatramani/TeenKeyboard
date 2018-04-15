//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Shanky(Prgm) on 4/14/18.
//  Copyright © 2018 Shashank Venkatramani. All rights reserved.
//

import UIKit
import CoreML

 var proxy : UITextDocumentProxy?

class KeyboardViewController: UIInputViewController {
    var totalText:String? = ""
    var overideable:Bool = false
    
    private let model = SentimentPolarity()
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func override(_ sender: Any) {
        if(overideable == true){
            proxy?.insertText("\n")
        }
    }
    @IBOutlet var nextKeyboardButton: UIButton?
    
    @IBAction func q(_ sender: Any) {
        proxy?.insertText("q")
        totalText = totalText! + "q"
    }
    @IBAction func w(_ sender: Any) {
        proxy?.insertText("w")
        totalText = totalText! + "w"
    }
    @IBAction func e(_ sender: Any) {
        proxy?.insertText("e")
        totalText = totalText! + "e"
    }
    @IBAction func r(_ sender: Any) {
        proxy?.insertText("r")
        totalText = totalText! + "r"
    }
    @IBAction func t(_ sender: Any) {
        proxy?.insertText("t")
        totalText = totalText! + "t"
    }
    @IBAction func y(_ sender: Any) {
        proxy?.insertText("y")
        totalText = totalText! + "y"
    }
    @IBAction func u(_ sender: Any) {
        proxy?.insertText("u")
        totalText = totalText! + "u"
    }
    @IBAction func i(_ sender: Any) {
        proxy?.insertText("i")
        totalText = totalText! + "i"
    }
    @IBAction func o(_ sender: Any) {
        proxy?.insertText("o")
        totalText = totalText! + "o"
    }
    @IBAction func p(_ sender: Any) {
        proxy?.insertText("p")
        totalText = totalText! + "p"
    }
    @IBAction func a(_ sender: Any) {
        proxy?.insertText("a")
        totalText = totalText! + "a"
    }
    @IBAction func s(_ sender: Any) {
        proxy?.insertText("s")
        totalText = totalText! + "s"
    }
    @IBAction func d(_ sender: Any) {
        proxy?.insertText("d")
        totalText = totalText! + "d"
    }
    @IBAction func f(_ sender: Any) {
        proxy?.insertText("f")
        totalText = totalText! + "f"
    }
    @IBAction func g(_ sender: Any) {
        proxy?.insertText("g")
        totalText = totalText! + "g"
    }
    @IBAction func h(_ sender: Any) {
        proxy?.insertText("h")
        totalText = totalText! + "h"
    }
    @IBAction func j(_ sender: Any) {
        proxy?.insertText("j")
        totalText = totalText! + "j"
    }
    @IBAction func k(_ sender: Any) {
        proxy?.insertText("k")
        totalText = totalText! + "k"
    }
    @IBAction func l(_ sender: Any) {
        proxy?.insertText("l")
        totalText = totalText! + "l"
    }
    @IBAction func shift(_ sender: Any) {
        proxy?.insertText("shift")
        totalText = totalText! + ""
    }
    @IBAction func z(_ sender: Any) {
        proxy?.insertText("z")
        totalText = totalText! + "z"
    }
    @IBAction func x(_ sender: Any) {
        proxy?.insertText("x")
        totalText = totalText! + "x"
    }
    @IBAction func c(_ sender: Any) {
        proxy?.insertText("c")
        totalText = totalText! + "c"
    }
    @IBAction func v(_ sender: Any) {
        proxy?.insertText("v")
        totalText = totalText! + "v"
    }
    @IBAction func b(_ sender: Any) {
        proxy?.insertText("b")
        totalText = totalText! + "b"
    }
    @IBAction func n(_ sender: Any) {
        proxy?.insertText("n")
        totalText = totalText! + "n"
    }
    @IBAction func m(_ sender: Any) {
        proxy?.insertText("m")
        totalText = totalText! + "m"
    }
    @IBAction func del(_ sender: Any) {
        proxy?.deleteBackward()
        
        totalText = String((totalText?.characters.dropLast())!)
        
        
        
    }
    @IBAction func space(_ sender: Any) {
        proxy?.insertText(" ")
        totalText = totalText! + " "
    }
    @IBAction func returnKey(_ sender: Any) {
        
        print(totalText)
        
       if((totalText! == "i wanna kill myself") || (totalText! == "suicide")) {
            label?.text = "Please head towards our app"
        } else if(makePrediction(textUse: totalText!) == true){
            proxy?.insertText("\n")
            totalText = ""
            print("positive")
        }
        else {
            
            label?.text = "Are you sure you want to send this?"
            
            overideable = true
            
            
        }
        totalText = ""
        
    }
    
    private let options: NSLinguisticTagger.Options = [.omitWhitespace, .omitPunctuation, .omitOther]
    private lazy var tagger:NSLinguisticTagger = .init(
        tagSchemes: NSLinguisticTagger.availableTagSchemes(forLanguage: "en"),
        options: Int(self.options.rawValue)
    )
    
    func makePrediction(textUse: String) -> Bool{
        let Features = features(text: textUse)
        
        let output = try! model.prediction(input: Features)
        
        switch output.classLabel {
        case "Pos":
            return true
        case "Neg":
            return false
        default:
            return true
        }
        
    }
    
    func features(text: String) -> [String : Double]{
        var wordCounts = [String : Double]()
        
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        
        tagger.enumerateTags(in: range, scheme: .nameType, options: options) { _, tokenRange, _, _ in
            let tokenUse = (text as NSString).substring(with: tokenRange).lowercased()
            
            
            guard tokenUse.count >= 3 else {
                return
            }
            
            if let value = wordCounts[tokenUse] {
                wordCounts[tokenUse] = value + 1.0
            } else {
                wordCounts[tokenUse] = 1.0
            }
        }
        return wordCounts
        
        
    }
    
   
    
    var keyboardView: UIView!
    
    func loadInterface() {
        let keyboardNIB = UINib(nibName: "KeyboardView", bundle: nil)
        keyboardView = keyboardNIB.instantiate(withOwner: self, options: nil) [0] as! UIView
        keyboardView.frame.size = view.frame.size
        view.addSubview(keyboardView)
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label?.text = ""
        proxy = textDocumentProxy as UITextDocumentProxy?
       
        nextKeyboardButton?.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        
        loadInterface()
        
        
        
        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton?.setTitleColor(textColor, for: [])
    }
    
}
