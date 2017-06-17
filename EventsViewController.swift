//
//  EventsViewController.swift
//  RideApp
//
//  Created by Yan Futerman on 16/06/2017.
//  Copyright © 2017 Yan Futerman. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController, UITextViewDelegate, IASKSettingsDelegate {
/*
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventRides.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)

        // Configure the cell...
        let eventRide = eventRides[indexPath.row] as EventRide
        cell.textLabel?.text = eventRide.eventName
        cell.detailTextLabel?.text = eventRide.eventDateTime

        return cell
    }
    
    
    // Settings
    fileprivate var _appSettingsViewController : IASKAppSettingsViewController? = nil
    fileprivate var _tabAppSettingsViewController : IASKAppSettingsViewController? = nil
    
    func appSettingsViewController() -> IASKAppSettingsViewController {
        if _appSettingsViewController == nil {
            _appSettingsViewController = IASKAppSettingsViewController()
            _appSettingsViewController!.delegate = self
        }
        
        return _appSettingsViewController!
    }
    
    func tabAppSettingsViewController() -> IASKAppSettingsViewController {
        return _tabAppSettingsViewController!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Settings initialization
        let barViewControllers = self.tabBarController?.viewControllers
        let navigationController = (barViewControllers![3] as! UINavigationController)
        _tabAppSettingsViewController = (navigationController.topViewController as! IASKAppSettingsViewController)
        _tabAppSettingsViewController?.delegate = self
        
        let enabled = UserDefaults.standard.bool(forKey: "AutoConnect")
        if enabled
        {
            self.tabAppSettingsViewController().setHiddenKeys(nil, animated: false)
        }
        else
        {
            var keys = Set<NSObject>();
            keys.insert("AutoConnectLogin" as NSObject)
            keys.insert("AutoConnectPassword" as NSObject)
            self.tabAppSettingsViewController().setHiddenKeys(keys, animated: false)
        }
        
    }
    
    
    // MARK: IASKAppSettingsViewControllerDelegate protocol
    func settingsViewControllerDidEnd(_ sender:IASKAppSettingsViewController)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!)
    {
        controller.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table View
    
    func settingsViewController(_ settingsViewController: IASKViewController, tableView: UITableView!, heightForHeaderForSection section: Int) -> CGFloat
    {
        let key:String = settingsViewController.settingsReader.key(forSection: section);
        
        if key == "IASKLogo"
        {
            return (UIImage(named:"Icon.png")?.size.height)!+25;
        }
        else if key == "IASKCustomHeaderStyle"
        {
            return 55.0;
        }
        else
        {
            return 0;
        }
    }
    
    func settingsViewController(_ settingsViewController: IASKViewController, tableView: UITableView!, viewForHeaderForSection section: Int) -> UIView!
    {
        let key: String? = settingsViewController.settingsReader.key(forSection: section);
        if key == "IASKLogo"
        {
            let imageName = "Icon.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            imageView.contentMode = UIViewContentMode.center
            return imageView;
        }
        else if key == "IASKCustomHeaderStyle"
        {
            let label = UILabel(frame: CGRect.zero)
            label.backgroundColor = UIColor.clear
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.red
            label.shadowColor = UIColor.white
            label.shadowOffset = CGSize(width: 0, height: 1)
            label.numberOfLines = 0
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.text = settingsViewController.settingsReader.title(forSection: section)
            return label;
        }
        else
        {
            return nil;
        }
    }
    
    
    func tableView(_ tableView: UITableView!, heightFor specifier: IASKSpecifier!) -> CGFloat
    {
        if specifier.key() == "customCell"
        {
            return 44*3;
        }
        else
        {
            return 0;
        }
    }
    
    func tableView(_ tableView: UITableView!, cellFor specifier: IASKSpecifier!) -> UITableViewCell!
    {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: specifier.key() as String) as? CustomViewCell
        
        if cell == nil {
            
            cell = Bundle.main.loadNibNamed("CustomViewCell", owner: self, options: nil)?.first as? CustomViewCell
            
        }
        
        let txt: String? = UserDefaults.standard.string(forKey: specifier.key())
        
        if  txt != nil
        {
            cell!.textView!.text = UserDefaults.standard.string(forKey: specifier.key())
        }
        else
        {
            cell!.textView!.text = specifier.defaultStringValue() as? String
        }
        
        cell!.textView?.delegate = self
        
        //        cell!.textLabel?.delete(self)
        //        cell!.setNeedsDisplay()
        return cell;
    }
    
    // MARK: - kIASKAppSettingChanged notification
    
    func settingDidChange(_ notification: Notification!)
    {
        if (notification.object as AnyObject).description == "AutoConnect"
        {
            let activeController:IASKAppSettingsViewController = self.tabBarController!.selectedIndex == 1 ?
                self.tabAppSettingsViewController() : self.appSettingsViewController()
            let enabled = UserDefaults.standard.bool(forKey: "AutoConnect")
            if (enabled)
            {
                activeController.setHiddenKeys(nil, animated: true)
            }
            else
            {
                var keys = Set<NSObject>();
                keys.insert("AutoConnectLogin" as NSObject)
                keys.insert("AutoConnectPassword" as NSObject)
                activeController.setHiddenKeys(keys, animated: true)
            }
        }
    }
    
    
    // MARK: - UITextViewDelegate (for CustomViewCell)
    func textViewDidChange(_ textView: UITextView)
    {
        UserDefaults.standard.set(textView.text, forKey: "customCell")
        NotificationCenter.default.post(name: Notification.Name(rawValue: kIASKAppSettingChanged), object:"customCell", userInfo:nil)
    }
    
    /*
     // MARK: - UIPopoverControllerDelegate
     func popoverControllerDidDismissPopover(_ popoverController: UIPopoverController)
     {
     self.currentPopoverController = nil
     }
     */
    
    // MARK: -
    
    func settingsViewController(_ sender: IASKAppSettingsViewController!, buttonTappedFor specifier: IASKSpecifier!)
    {
        if specifier.key() == "ButtonDemoAction1"
        {
            let alert = UIAlertController(title: "Demo Action 1 called", message: nil, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            sender.present(alert, animated: true, completion: nil)
        }
        else if specifier.key() == "ButtonDemoAction2"
        {
            let newTitle = UserDefaults.standard.string(forKey: specifier.key())
            if newTitle == "Logout"
            {
                UserDefaults.standard.set("Login", forKey: specifier.key())
            }
            else
            {
                UserDefaults.standard.set("Logout", forKey: specifier.key())
            }
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // cancel new event creation
    @IBAction func cancelToEventsViewController (segue:UIStoryboardSegue){
        
    }
    
    // save new event
    @IBAction func saveEventRideDetails (segue: UIStoryboardSegue){
        
    }
    
    // cancel update of ride details
    @IBAction func cancelUpdateToEventsViewController (segue:UIStoryboardSegue){
        
    }
    
    // save updated details
    @IBAction func saveUpdateEventRideDetails (segue: UIStoryboardSegue){
        
    }

}


var eventRides:[EventRide] = eventRidesData

