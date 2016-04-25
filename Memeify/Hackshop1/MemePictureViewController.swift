//
//  MemePictureViewController.swift
//  Hackshop1
//
//  Created by SAMEER SURESH on 2/19/16.
//  Copyright © 2016 SAMEER SURESH. All rights reserved.
//

import UIKit

class MemePictureViewController: UIViewController {
    
    var imageName = ""
    var timer = NSTimer()
    var times = 0
    var colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.blueColor(), UIColor.blackColor(), UIColor.brownColor(), UIColor.magentaColor(), UIColor.yellowColor(), UIColor.orangeColor(), UIColor.cyanColor()]
    
    @IBOutlet weak var overlay: UIImageView!
    @IBOutlet weak var memePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memePic.image = UIImage(named: imageName)
        overlay.image = overlay.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        overlay.tintColor = UIColor.redColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: "changeColor", userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeColor(){
        if times < 30{
            overlay.image = overlay.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            overlay.tintColor = colors[times%colors.count]
            times = times + 1
        }
        else{
            timer.invalidate()
        }
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
