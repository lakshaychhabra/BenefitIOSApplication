//
//  MyWorkoutsScreenViewController.swift
//  Benefit
//
//  Created by Delta One on 28/01/18.
//  Copyright © 2018 IOSD. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVKit



class MyWorkoutsScreenViewController: UIViewController
{


    @IBOutlet var videoView: UIView!
    @IBOutlet var progressPercent: UILabel!
    @IBOutlet var progressView: UIView!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var downloadButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let itemsList = ["PremiumFeatureCell", "CalendarCell", "TodaysWorkout", "TotalWorkout", "WorkoutDescription", "WorkoutInfo", "Exercise"]
    var numberOfExercises = 0
    let screenHeight = UIScreen.main.bounds.height
    let scrollViewContentHeight = 1200 as CGFloat
    let scrollViewContentWidth = UIScreen.main.bounds.width
    var isRestDay = false
    
     let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
    var exerciseNameArray = [String]()
    var exerciseID = [String]()
    var timeTaken = [String]()
    var reps = [String]()
    var monthNumber : String = "00"
    let dateFormatter = DateFormatter()
    var dateSelected : String = ""
    let tok = ["Authorization" : LoginScreenViewController.token]
    var isDownloading : Bool = false
    var player : AVPlayer!
    var playerLayer : AVPlayerLayer!
    let controller = AVPlayerViewController()
    var showVideo = false
    var exerciseVideoArray = [String]() //aws links
    var urlArray = [String]() // to get aws links
    var storedVideoUrl = [URL]()
    var isInfoDownloaded = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        tableView.tableFooterView = UIView()
        registerCellNib(named: "PremiumFeatureCell", with: tableView)
        registerCellNib(named: "WorkoutDescription", with: tableView)
        registerCellNib(named: "WorkoutInfo", with: tableView)
        registerCellNib(named: "Exercise", with: tableView)
        registerCellNib(named: "RestDayCell", with: tableView)
        
        progressView.isHidden = true
        
        navigationBarLogo()
        
        self.videoView.isHidden = true
        if isDownloading {
            self.progressView.isHidden = false
        }
        
        let todaysDate = Date()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateSelected = dateFormatter.string(from: todaysDate)
        print(dateSelected)
        configuringTableViews()
        NotificationCenter.default.addObserver(self, selector: #selector(self.changeInDate(_:)), name: NSNotification.Name(rawValue: "newDate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.downloading(notification:)), name: Notification.Name("url"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.showVideoPlayer(notification:)), name: Notification.Name("videos"), object: nil)
        
    }
    
    @objc func changeInDate(_ notification: NSNotification){
        
        configuringTableViews()
        
    }
    
    func navigationBarLogo(){
        
        let logo = UIImage(named: "benefit_logo")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = imageView
    }
    
    func configuringTableViews(){
        
        let exerciseUrl = "http://13.59.14.56:5000/api/v1/workout/user/get?date=\(dateSelected)"
        
        
        activityIndicatorFunc()
        activityIndicator.startAnimating()
        Alamofire.request(exerciseUrl, method: .get, headers: tok).responseJSON { (response) in
            
            print(response)
            if let response = response.result.value {
                let data : JSON = JSON(response)
                if data["data"] == JSON.null {
                    print("No Data for the day")
                    self.numberOfExercises = 0
                    self.tableView.reloadData()
                }
                else {
                    let exercises = data["data"]["workout"]["exercises"]
                    var i = 0
                    var exerciseId = String()
                    var reps = String()
                    var timeTaken = String()
                    var exerciseName = String()
                    
                    print(data["data"]["workout"]["exercises"], exercises.count)
                    
                    self.exerciseID.removeAll()
                    self.reps.removeAll()
                    self.timeTaken.removeAll()
                    self.exerciseNameArray.removeAll()
                    
                    while i < exercises.count {
                        
                        exerciseId = exercises[i]["exercise"]["_id"].rawString()!
                        reps = exercises[i]["reps"].rawString()!
                        timeTaken = exercises[i]["exercise"]["timeTaken"].rawString()!
                        exerciseName = exercises[i]["exercise"]["name"].rawString()!
                        
                        self.exerciseID.append(exerciseId)
                        self.reps.append(reps)
                        self.timeTaken.append(timeTaken)
                        self.exerciseNameArray.append(exerciseName)
                        
                        i += 1
                    }
                    
                    print(self.exerciseNameArray, self.exerciseID)
                    self.numberOfExercises = self.exerciseID.count
                    self.tableView.reloadData()
                }
                 self.activityIndicator.stopAnimating()
               
            }
        }
        
    }
    
    func activityIndicatorFunc() {
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    @IBAction func downloadButtonPressed(_ sender: UIButton) {
        
        if numberOfExercises == 0 {
            
            print("No Exercise for Today")
            displayAlert(title: "No Exercise For The Day", message: "Your Exercise the day is not yet Updated")
            
        }
        else {
            print("Downloading Videos")
            
       
           
            gettingUrlForDownload()
           
            
            
                    print("info is downloaded")
            
            
            
            
           
           print("Reached end of download")
            
        }
       
        
        
    }
    
    
    
    func gettingUrlForDownload(){
             print("getting URRl")
        
            var i = 0
            while i < self.exerciseID.count {
                print(self.exerciseID[i])
                self.urlArray.append("http://13.59.14.56:5000/api/v1/workout/exercise/\(self.exerciseID[i])/url/?type=tutorial")
                
                Alamofire.request(self.urlArray[i], method: .get, headers: self.tok).responseJSON { (response) in
                    
                    print(response)
                    if let response = response.result.value {
                        let data : JSON = JSON(response)
                        if data["data"] == JSON.null {
                            print("Cannot find data")
                        }
                        else{
                            print("Appending")
                            let dat = data["data"].rawString()!
                            self.exerciseVideoArray.append(dat)
                            print("array inside", self.exerciseVideoArray)
                            print(self.exerciseID.count, self.exerciseVideoArray.count)
                            if self.exerciseID.count == self.exerciseVideoArray.count {
                                print("sending flag")
                                NotificationCenter.default.post(name: Notification.Name("url"), object: nil)

                                self.isInfoDownloaded = true
                            }
                        }
                    }
                }
                
                i += 1
            }

        
        
   
        
        
    }
    
    @objc func downloading(notification: Notification){
        
         print("The video Array is ", self.exerciseVideoArray)
        
        let requestGroup =  DispatchGroup()
        
        print("Downloading videos function")
        var j = 0
        
        for i in exerciseID {
            
             requestGroup.enter()
            Alamofire.request(self.exerciseVideoArray[j]).downloadProgress { (progress) in
                self.progressView.isHidden = false
                print(progress.fractionCompleted)
                self.progressBar.progress = Float(progress.fractionCompleted)
                self.progressPercent.text = "\(round(progress.fractionCompleted * 100))%"
                self.isDownloading = true
                if progress.fractionCompleted == 1 {
                    self.isDownloading = false
                    self.progressView.isHidden = true
                    
                }
                }.responseData { (response) in
                   
                    self.progressView.isHidden = true
                    print("helloJi Chai peelo")
                    print(response)
                    //print(response.result.value!)
                    print(response.result.description)
                    
                    if let data = response.result.value {
                     //   name = self.exerciseID[i]
                        
                        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                        let videoURL = documentsURL.appendingPathComponent("\(i).mp4")
                        print(videoURL)
                        
                        do {
                            try data.write(to: videoURL)
                            self.storedVideoUrl.append(videoURL)
                            print(data)
                        } catch {
                            print("Something went wrong!")
                        }
                        
                        print(videoURL)
                        print(self.storedVideoUrl.count)
                        print("The Stored Videos Address", self.storedVideoUrl)
                        
                        
                        if self.storedVideoUrl.count == self.exerciseID.count {
                            self.showVideo = true
                            
                            print("all videos downloaded", self.storedVideoUrl)
                            NotificationCenter.default.post(name: Notification.Name("videos"), object: nil)
                            
                            self.downloadButton.setTitle("Play Videos", for: .normal)
                        }
                        
                    }
            }
            print(j)
            j += 1
            requestGroup.leave()
        }
        
        
        
    }
    
    
    @objc func downloadingVideos (notification: Notification){
        
        let requestGroup =  DispatchGroup()
        
        print("Downloading videos function")
        
        var name : String!
            var i = 0
        
            while i < self.exerciseID.count {
                
                
                print("The video Array is ", self.exerciseVideoArray)
               
                
                

                Alamofire.request(self.exerciseVideoArray[i]).downloadProgress { (progress) in
                    self.progressView.isHidden = false
                    print(progress.fractionCompleted)
                    self.progressBar.progress = Float(progress.fractionCompleted)
                    self.progressPercent.text = "\(round(progress.fractionCompleted * 100))%"
                    self.isDownloading = true
                    if progress.fractionCompleted == 1 {
                        self.isDownloading = false
                        self.progressView.isHidden = true
                        
                      }
                    }.responseData { (response) in
                        requestGroup.enter()
                        self.progressView.isHidden = true
                        print("helloJi Chai peelo")
                        print(response)
                        //print(response.result.value!)
                        print(response.result.description)
                        
                        if let data = response.result.value {
                            name = self.exerciseID[i]
                            
                            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                            let videoURL = documentsURL.appendingPathComponent("\(name!).mp4")
                            print(videoURL)
                            
                            do {
                                try data.write(to: videoURL)
                                self.storedVideoUrl.append(videoURL)
                                print(data)
                            } catch {
                                print("Something went wrong!")
                            }
                            
                            print(videoURL)
                            print(self.storedVideoUrl.count)
                            print("The Stored Videos Address", self.storedVideoUrl)
                            
                            
                            if self.storedVideoUrl.count == self.exerciseID.count {
                            self.showVideo = true
                                
                                print("all videos downloaded", self.storedVideoUrl)
                                 NotificationCenter.default.post(name: Notification.Name("videos"), object: nil)
                                
                            self.downloadButton.setTitle("Play Videos", for: .normal)
                            }
                            
                        }
                }
                
                
                print("cycle : ", i)
                i += 1
                requestGroup.leave()
               
                
                print("The Stored Videos Address after leaving", self.videosURL)
            }

        
       
    }

    var videosURL = [AVPlayerItem]()
    
    func convertToPlayerItem() {
        
        var i = 0
        while i < exerciseVideoArray.count {
            videosURL.append(AVPlayerItem(url: storedVideoUrl[i]))
          
          i += 1
        }
        
    }

  
   @objc func showVideoPlayer(notification: Notification){
        
        DispatchQueue.main.async {
        
            self.convertToPlayerItem()
            
            self.videoView.isHidden = false
            self.player = AVQueuePlayer(items: self.videosURL)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer.frame = self.videoView.bounds
            self.videoView.layer.addSublayer(self.playerLayer)
            print("Doing Stuff")
            self.player.play()
            
        }
    }
    

    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension MyWorkoutsScreenViewController: CalendarViewControllerDelegate
{
    func respondToChangeInSelectedDate(for dayNumber: Int, _ month: String, _ year: Int)
    {
        print(dayNumber, month, year)
//        if dayNumber % 7 == 0
//        {
//            isRestDay = true
//            tableView.reloadData()
//        }
//        else
//        {
//            isRestDay = false
//            tableView.reloadData()
//        }
        
        let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
        
        
        switch month {
        case months[0]:
            monthNumber = "01"
        case months[1]:
            monthNumber = "02"
        case months[2]:
            monthNumber = "03"
        case months[3]:
            monthNumber = "04"
        case months[4]:
            monthNumber = "05"
        case months[5]:
            monthNumber = "06"
        case months[6]:
            monthNumber = "07"
        case months[7]:
            monthNumber = "08"
        case months[8]:
            monthNumber = "09"
        case months[9]:
            monthNumber = "10"
        case months[10]:
            monthNumber = "11"
        case months[11]:
            monthNumber = "12"
        default:
            print("Nooo")
        }
        dateSelected = "\(dayNumber)-\(monthNumber)-\(year)"
        let dateNotif : [String : String] = ["date" : dateSelected]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDate"), object: nil, userInfo: dateNotif)
        
        print(dateSelected)
        
    }
}

extension MyWorkoutsScreenViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MyWorkoutsScreenViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        if indexPath.section == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PremiumFeatureCell", for: indexPath) as! PremiumFeatureCell
            cell.lockImageView.image = UIImage()
            cell.titleLabel.textColor = UIColor.black
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CalendarCell", for: indexPath)
            let calendarView = cell.contentView.viewWithTag(13) as! MyCalendar
            calendarView.delegateForHandlingDates = self
            cell.selectionStyle = .none
            return cell
        }
        else if indexPath.section <= 5
        {
            if isRestDay
            {
               let cell = tableView.dequeueReusableCell(withIdentifier: "RestDayCell", for: indexPath)
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                return cell
            }
            else
            {
                let cell = tableView.dequeueReusableCell(withIdentifier: itemsList[indexPath.section], for: indexPath)
                cell.selectionStyle = .none
                cell.isUserInteractionEnabled = false
                return cell
            }
            
            
            
        }
        else
        {
           let cell = tableView.dequeueReusableCell(withIdentifier: "Exercise", for: indexPath) as! ExerciseTableViewCell
            cell.name.text = exerciseNameArray[indexPath.row]
            cell.reps.text = reps[indexPath.row]
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            return cell
        }
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        if isRestDay
        {
            return 3
        }
        else
        {
            return 7
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if section < 6 {
        return 1
        }
        else {
            return numberOfExercises
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        if section == 6
        {
            return 15
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
}
