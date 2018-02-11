//
//  CardViewCell.swift
//  Benefit
//
//  Created by Delta One on 01/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class CardViewCell: UITableViewCell
{

    @IBOutlet weak var cardViewImage: UIImageView!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
