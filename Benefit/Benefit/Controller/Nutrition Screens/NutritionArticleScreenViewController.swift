//
//  NutritionArticleScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 02/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class NutritionArticleScreenViewController: UIViewController
{
    
    let cellList = ["ArticleTitle", "FullSizedImageViewCell", "ShareArticle", "NutritionArticleViewCell"]
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        registerCellNib(named: "FullSizedImageViewCell", with: tableView)
        registerCellNib(named: "NutritionArticleViewCell", with: tableView)
        
    }   
}

extension NutritionArticleScreenViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellList[indexPath.section], for: indexPath) as! FullSizedImageViewCell
            cell.croppedImage.image = UIImage(named: "fn1cropped.png")
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellList[indexPath.section], for: indexPath)
            if indexPath.section == 3
            {
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0)
            }
            return cell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return cellList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
}

extension NutritionArticleScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
