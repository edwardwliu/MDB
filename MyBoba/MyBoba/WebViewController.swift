//
//  WebViewController.swift
//  MyBoba
//
//  Created by Edward Liu on 2/29/16.
//  Copyright © 2016 Edward Liu. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    @IBOutlet weak var WebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=boba%20places%20near%20me")
        //Create the NSURL request, make notw how the NSURL is wrapped
        let request = NSURLRequest(URL: url!)
        //Load the request
        WebView.loadRequest(request)

    
        // Do any additional setup after loading the view.
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
