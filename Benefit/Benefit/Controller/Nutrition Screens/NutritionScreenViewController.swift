
//
//  NutritionScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 02/02/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class NutritionScreenViewController: UIViewController
{
    let imageList = ["fn1.png", "fn2.png"]
    let nutritionList = ["PremiumFeatureCell", "SecondaryCell", "CardViewCell"]
    var isMyNutritionLocked = true
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        for nutrition in nutritionList
        {
            registerCellNib(named: nutrition, with: tableView)
        }
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.backgroundColor = UIColor.clear

    }


}

extension NutritionScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            performSegue(withIdentifier: "goToMyNutritionLocked", sender: self)
        }
        else if indexPath.section == 1
        {
            performSegue(withIdentifier: "goToMyNutrition", sender: self)
        }
        else if indexPath.section == 2
        {
            performSegue(withIdentifier: "goToProteinFactsAndSources", sender: self)
        }
    }
}

extension NutritionScreenViewController: UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 15
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: "EEEEEE")
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return nutritionList.count - 1 + imageList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.leftLogoImageView.image = UIImage(named: "ic_my_nutrition_24dp.png")
            cell.lockImageView.image = UIImage(named: "ic_locked_24dp.png")
            cell.titleLabel.text = "MY NUTRITION PLAN"
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondaryCell", for: indexPath) as! SecondaryCell
            cell.secondaryLabel.text = "NUTRITION INSIGHTS"
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardViewCell", for: indexPath) as! CardViewCell
            cell.cardViewImage.image = UIImage(named: imageList[indexPath.section - 2])
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
        
    }
    
    
}
