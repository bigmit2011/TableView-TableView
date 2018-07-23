//
//  FirstTableViewCell.swift
//  testProduct
//
//  Created by Amit on 7/17/18.
//  Copyright © 2018 Amit. All rights reserved.
////

import UIKit

protocol LabelCellDelegate {
    func func1(sender:Any)
}

    
    
class FirstTableViewCell: UITableViewCell {


    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var FolderLabel: UILabel!
    
    var delegate: LabelCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        //print(FolderLabel)
        
        FolderLabel.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(FirstTableViewCell.handleTap(recognizer:)))
        recognizer.numberOfTapsRequired = 1
        self.FolderLabel.addGestureRecognizer(recognizer) //crashing???
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer){
        delegate!.func1(sender: self)
    }
    func setCell (cell : FolderCell){
        self.ImageView.image = cell.image
        self.FolderLabel.text = cell.label
    }
}


