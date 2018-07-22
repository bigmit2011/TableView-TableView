//
//  SecondTableViewCell.swift
//  testProduct
//
//  Created by Amit on 7/18/18.
//  Copyright © 2018 Amit. All rights reserved.
//

import UIKit

class SecondTableViewCell: UITableViewCell {
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var FolderLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
          }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
        
    func setCell (cell : FolderCell){
            self.ImageView.image = cell.image
            self.FolderLabel.text = cell.label
        
        
    }

}
