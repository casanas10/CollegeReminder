//
//  AddNoteTableViewController.swift
//  College Reminder
//
//  Created by Anthony Colas on 11/21/15.
//  Copyright © 2015 alejandro casanas. All rights reserved.
//

import UIKit
import Parse
import Bolts
import Social
import Foundation

public extension String {
    var NS: NSString { return (self as NSString) }
}
class AddNoteTableViewController: UITableViewController {
    
    //@IBOutlet weak var titleField: UITextField!
    
    //@IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    var pageSize = CGSize()
    
    var object: PFObject!
   // var CGSIZE pageSize;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(self.object != nil){
            self.titleField?.text = self.object["title"] as? String
            self.textView?.text = self.object["text"] as? String
            
        }else{
            self.object = PFObject(className: "Notes")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /*   func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }*/
    
    // MARK: - Table view data source
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        self.object["username"] = PFUser.currentUser()?.username
        self.object["title"] = self.titleField?.text
        self.object["text"] = self.textView?.text
       
        self.object.saveEventually(){ (success,error) -> Void in
            
            if(error == nil){
                
            }else{
                print(error!.userInfo)
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func shareToFacebook(sender: UIButton) {
        /*pageSize = CGSizeMake(850, 1000)
        
        var fileToUpload = PFObject(className: "Notes")

        var path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentDirectory = path[0]
        var pdfPath = documentDirectory.NS.stringByAppendingPathComponent((self.titleField?.text)! + ".pdf")
        generatePDF(pdfPath)
        var PDFUrl = NSURL(string: pdfPath)            //convert pdfPath string to NSURL
       // var myData = NSData(contentsOfURL: PDFUrl!)
        
        //var parseFile = PFFile(name: "image.png", data: myData!)
       // fileToUpload["pdffile"] = parseFile
*/
        
        var shareToFacebook: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        self.presentViewController(shareToFacebook, animated: true, completion: nil)
        shareToFacebook.setInitialText(self.textView?.text)
        //shareToFacebook.addURL(PDFUrl)
        
    }
  /*
    func generatePDF(filePath: NSString)
    {
        UIGraphicsBeginPDFContextToFile(filePath as String, CGRectZero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 850, 1100), nil)
        drawBack()
        drawText()
        UIGraphicsEndPDFContext()
        
    }
    
    func drawBack(){
        var context = UIGraphicsGetCurrentContext()
        var rect = CGRectMake(0, 0, pageSize.width, pageSize.height)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, rect)
    }
    
    func drawText(){
        var context = UIGraphicsGetCurrentContext()
        var font = UIFont(name: "Helvetica", size: 14)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        var textRect = CGRectMake(0, 0, textView.frame.size.width, textView.frame.size.height)
        var myString = NSString()
        myString = self.textView.text
       // let textFontAttributes = [
         //   NSFontAttributeName: font,
           // lineBreakMode: NSLineBreakMode.ByTruncatingMiddle,
            //alignment: NSTextAlignment.Lef
        //
        var paragraphstyle = NSMutableParagraphStyle()
        paragraphstyle.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle
        paragraphstyle.alignment = NSTextAlignment.Left
        if let actualFont = font {
        let textFontAttributes = [
            NSFontAttributeName: actualFont,
            NSParagraphStyleAttributeName: paragraphstyle
        ]
       // var attributes: [NSObject : AnyObject] = [ NSFontAttributeName: font, NSParagraphStyle: paragraphstyle]
        
       // myString.drawInRect(textRect, withAttributes: ["withFont": font, "lineBreakMode": NSLineBreakMode.ByWordWrapping, "alignment": NSTextAlignment])
        myString.drawInRect(textRect, withAttributes: textFontAttributes)
        }
        
    }
    
    */
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
    // Configure the cell...
    return cell
    }
    */
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}