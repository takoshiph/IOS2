//
//  ViewController.swift
//  StopWatch-Youtube
//
//  Created by Elvin Ross Fabella on 2023-01-15.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    // Mark: = Variables

    var hours = 0
    var minutes = 0
    var seconds = 0
    var lappedTimes:[String] = []
    
    //Timer
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
    }

    @IBAction func start(_ sender: UIButton) {
        //Start counting the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(count), userInfo: nil, repeats: true)
        startButton.isHidden = true
    }
    
    @IBAction func lapButton(_ sender: UIButton) {
        let currentTime = "\(hours):\(minutes):\(seconds)"
        lappedTimes.append(currentTime)
        
        let indexPath = IndexPath(row: lappedTimes.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
         
    }
    @IBAction func pauseButton(_ sender: UIButton) {
        timer.invalidate()
        startButton.isHidden = false

    }
    
    @IBAction func resetButton(_ sender: UIButton) {
        resetTimer()
    }
    func resetTimer(){
        lappedTimes = []
        hours = 0
        minutes = 0
        seconds = 0
        timer.invalidate()
        secondLabel.text = "00"
        minuteLabel.text = "00"
        hourLabel.text = "00"
        tableView.reloadData()
        startButton.isHidden = false

    }
    
    
    @objc fileprivate func count() {
        seconds += 1
        secondLabel.text = "\(seconds)"
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        if minutes == 60 {
            seconds = 0
            minutes = 0
            hours += 1
        }
        if hours == 24{
            resetTimer()
            
        }
        secondLabel.text = "\(seconds)"
        minuteLabel.text = minutes == 0 ? "00" : "\(minutes)"
        hourLabel.text = hours == 0 ? "00j" : "\(hours)"
        
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lappedTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = lappedTimes[indexPath.row]
        cell.selectionStyle = .none
        return cell

    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            lappedTimes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}
