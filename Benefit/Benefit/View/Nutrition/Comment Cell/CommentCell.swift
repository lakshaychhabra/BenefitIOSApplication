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
    func commentMealTextViewDidBeginEditing(on row: Int)
    func saveButtonPressed(with comment: String, on row: Int)
}

class CommentCell: UITableViewCell, UITextViewDelegate
{
    @IBOutlet weak var commentMealTextView: UITextView!
    var delegate: CommentMealDelegate?
    var row: Int?
    override func awakeFromNib()
    {
        super.awakeFromNib()
        commentMealTextView.delegate = self
        commentMealTextView.text = "Comment on this meal"
        commentMealTextView.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        delegate?.commentMealTextViewDidBeginEditing(on: row!)
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
    @IBAction func saveButtonPressed(_ sender: UIButton)
    {
        if let comment = commentMealTextView.text
        {
            commentMealTextView.text = "Comment on this meal"
            commentMealTextView.textColor = UIColor.lightGray
            delegate?.saveButtonPressed(with: comment, on: row!)
        }
    }
    
}
