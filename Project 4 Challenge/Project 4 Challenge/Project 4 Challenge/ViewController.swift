//
//  ViewController.swift
//  Project 4 Challenge
//
//  Created by Walery Łojko on 03/01/2023.
//

import UIKit
import WebKit


class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var progressView: UIProgressView!
    
    var website = ""
    
    var websites = ["google.com", "apple.com", "hackingwithswift.com", "allegro.pl", "justjoin.it", "peugeot.pl"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = website
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        
        let left = UIBarButtonItem(barButtonSystemItem: .rewind, target: webView, action: #selector(webView.goBack))
        let right = UIBarButtonItem(barButtonSystemItem: .fastForward, target: webView, action: #selector(webView.goForward))
        
        toolbarItems = [progressButton, spacer, left, right]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .prior, context: nil)
        
        let url = URL(string: "https://" + website)!
        
        if websites.contains(website) {
            
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        } else {
            let ac = UIAlertController(title: "It's Blocked", message: "The url is isn't allowed.", preferredStyle: .alert)
                      ac.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: nil))
                      present(ac, animated: true)
        }
    
    }
    
    
    
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website) {

                    decisionHandler(.allow)
                    print(host)
                    return
                }
            }
        }
       decisionHandler(.cancel)
    }
}

