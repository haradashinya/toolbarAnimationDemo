//
//  ViewController.swift
//  toolbarAnimationDemo//


import UIKit

class ViewController: UIViewController,UIWebViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate {
    var webView:UIWebView!

    let urlStr:String = "https://www.youtube.com"

    var toolbarFrame:CGRect!


    let radiusOfIndiCator:CGFloat = 44
    let offsetYOfToolBar:CGFloat = 44
    let durationOfToolBar:Double = 0.4
    let boundaryOfY = 200

    override func viewDidLayoutSubviews() {
        if self.toolbarFrame == nil {
            self.toolbarFrame = self.navigationController!.toolbar.frame
            self.toolbarFrame.origin.y = self.view.frame.size.height + offsetYOfToolBar

        }
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Add WebView
        self.webView = UIWebView(frame: CGRectMake(0,0, self.view.frame.size.width,self.view.frame.size.height))
        let req:NSURLRequest = NSURLRequest(URL: NSURL(string: self.urlStr)!)
        self.webView.delegate  = self

        self.webView.loadRequest(req)
        self.view.addSubview(webView)
        self.updateToolbar()
        self.navigationController?.toolbar.hidden = true


    }


    func scrollViewDidScroll(scrollView: UIScrollView) {

        let scrollY = scrollView.layer.presentationLayer().bounds.origin.y
            if Int(scrollY) < self.boundaryOfY  {
                // hide toolbar
                let nextY = self.toolbarFrame.origin.y + self.offsetYOfToolBar

                UIView.animateWithDuration(self.durationOfToolBar) {
                    self.navigationController?.toolbar.frame.origin.y = nextY
                    return
                }



            }else{
                // show toolbar
                self.navigationController?.toolbar.hidden = false

                let nextY = self.toolbarFrame.origin.y - self.offsetYOfToolBar

                UIView.animateWithDuration(self.durationOfToolBar) {
                    self.navigationController?.toolbar.frame.origin.y = nextY
                    
                    return
                }
                
                



        }

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.toolbar.barTintColor = UIColor.whiteColor()
        
    }

    func setTabBarVisible(visible:Bool, animated:Bool) {

        //* This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time

        // bail if the current state matches the desired state
        if (tabBarIsVisible() == visible) { return }
        // get a frame calculation ready
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)


        let duration:NSTimeInterval = (animated ? 0.3 : 0.0)

        //  animate the tabBar
        if frame != nil {
            UIView.animateWithDuration(duration) {
                self.tabBarController?.tabBar.frame = CGRectOffset(frame!, 0, offsetY!)
                return
            }
        }
    }

    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.scrollView.delegate = self

    }

    func tabBarIsVisible() ->Bool {
        return self.tabBarController?.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame)
    }

    func updateToolbar(){



    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

