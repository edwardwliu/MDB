//
//  WebTabViewController.swift
//  TabDemo
//
//  Created by Virindh Borra on 10/31/15.
//  Copyright © 2015 Virindh Borra. All rights reserved.
//

import UIKit

class WebTabViewController: UIViewController {

    @IBAction func backbutton(sender: AnyObject) {
    }
    @IBAction func refreshbutton(sender: AnyObject) {
    }
    @IBAction func forwardbutton(sender: AnyObject) {
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Create the Google NSURL
        let url = NSURL(string: "https://www.google.com")
        //Create the NSURL request, make notw how the NSURL is wrapped
        let request = NSURLRequest(URL: url!)
        //Load the request
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
