//
//  ViewController.swift
//  Panic
//
//  Created by Mangesh Karekar on 12/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var redView: CircleView!
    @IBOutlet weak var yellowView: CircleView!
    @IBOutlet weak var greenView: CircleView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"navigationImage"), for: .compact)
        animateViews()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    private func animateViews(){
        UIViewAnimations.shrink(view: redView)
        UIViewAnimations.shrink(view: yellowView)
        UIViewAnimations.shrink(view: greenView)
    }
}

