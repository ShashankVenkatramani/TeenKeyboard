//
//  ViewController.swift
//  TeenKeyboard
//
//  Created by Shanky(Prgm) on 4/14/18.
//  Copyright © 2018 Shashank Venkatramani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func callPhone(_ sender: Any) {
        let url: NSURL = URL(string: "TEL://6692943242")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

