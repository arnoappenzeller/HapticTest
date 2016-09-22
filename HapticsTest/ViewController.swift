//
//  ViewController.swift
//  HapticsTest
//
//  Created by Arno on 22.09.16.
//  Copyright © 2016 APPenzeller. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UITableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Haptic Feedback Test"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 3
        default:
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Impact Feedback"
        case 1:
            return "Selection Feedback"
        case 2:
            return "Notification Feedback"
        case 3:
            return "Old Vibration Feedback"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "Trigger impact feedback"
        case 1:
            cell.textLabel?.text = "Trigger selection feedback"
        case 2:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Trigger success notification feedback"
            case 1:
                cell.textLabel?.text = "Trigger warning notification feedback"
            case 2:
                cell.textLabel?.text = "Trigger error notification feedback"
            default:
                break
            }
        case 3:
            cell.textLabel?.text = "Trigger old vibration feedback"
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            triggerImpactFeedback()
        case 1:
            triggerSelectionFeedback()
        case 2:
            let notificationFeedbackType:UINotificationFeedbackType
            switch indexPath.row {
            case 0:
                notificationFeedbackType = .success
            case 1:
                notificationFeedbackType = .warning
            case 2:
                notificationFeedbackType = .error
            default:
                notificationFeedbackType = .error // ;-)
            }
            triggerNotifactionHapticForType(type: notificationFeedbackType)
        case 3:
            triggerGoodOldVibration()
        default:
            break
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    
    //MARK: - haptic methods
    func triggerImpactFeedback(){
        let feedback = UIImpactFeedbackGenerator()
        
        feedback.prepare()
        
        /*NOTE: 
         This is not the best example for the usage of prepar.
        Apple says in it's doc that you should use prepare at short time before you expect the impact to fire to reduce latency
        In this case for simplicity we just fire when it's done
        For more info see the doc: https://developer.apple.com/reference/uikit/uifeedbackgenerator */
        
        feedback.impactOccurred()
    }
    
    func triggerSelectionFeedback(){
        let feedback = UISelectionFeedbackGenerator()
        feedback.prepare()
        feedback.selectionChanged()
    }
    
    func triggerNotifactionHapticForType(type:UINotificationFeedbackType){
        let feedback = UINotificationFeedbackGenerator()
        feedback.prepare()
        feedback.notificationOccurred(type)
    }
    
    func triggerGoodOldVibration(){
         AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
    

}

