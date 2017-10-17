//
//  MessageTableViewCell.swift
//  Panic
//
//  Created by Mangesh Karekar on 17/10/2017.
//  Copyright © 2017 Mangesh. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell,UITextViewDelegate{

    @IBOutlet weak var messageText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 50))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(resignKeyboard))
        toolBar.items = [doneButton]
        messageText.inputAccessoryView = toolBar
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func resignKeyboard(){
        messageText.resignFirstResponder()
    }
}
