//
//  HIITViewController.swift
//  Benefit
//
//  Created by Delta One on 26/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit

class HIITViewController: UIViewController
{
    let listItems = ["HIITBack", "FullSizedImageViewCell", "WorkoutRoutine1", "WorkoutRoutine2"]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        registerCellNib(named: "FullSizedImageViewCell", with: tableView)
        tableView.tableFooterView = UIView()
        
    }

    
    @IBAction func backButtonPressed(_ sender: UIButton)
    {
        print("Back button pressed")
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()

    }
}

extension HIITViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: listItems[indexPath.section], for: indexPath) as! FullSizedImageViewCell
            cell.croppedImage.image = UIImage(named: "fw1cropped.png")
            return cell
        }
        else
        {
            return tableView.dequeueReusableCell(withIdentifier: listItems[indexPath.section], for: indexPath)
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
}

extension HIITViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0
        {
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
