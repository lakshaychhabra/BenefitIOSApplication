//
//  CommentCell.swift
//  Benefit
//
//  Created by Delta One on 15/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

protocol CommentMealDelegate
{
    func commentMealTextViewDidBeginEditing()
}

class CommentCell: UITableViewCell, UITextViewDelegate
{
    @IBOutlet weak var commentMealTextView: UITextView!
    var delegate: CommentMealDelegate?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        commentMealTextView.delegate = self
        commentMealTextView.text = "Comment on this meal"
        commentMealTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        print("HEL")
        delegate?.commentMealTextViewDidBeginEditing()
        if textView.textColor == .lightGray
        {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if textView.text.isEmpty
        {
            textView.text = "Comment on this meal"
            textView.textColor = UIColor.lightGray
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

    }

}
