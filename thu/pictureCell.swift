//
//  pictureCell.swift
//  thu
//
//  Created by TRI TRAN on 4/13/17.
//  Copyright © 2017 TRI TRANthutran. All rights reserved.
//

import UIKit

class pictureCell: UICollectionViewCell {
    @IBOutlet weak var picImg: UIImageView!
    
    
    // default func
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // alignment
        let width = UIScreen.mainScreen().bounds.width
        picImg.frame = CGRectMake(0, 0, width / 3, width / 3)
    }

    
    
}
