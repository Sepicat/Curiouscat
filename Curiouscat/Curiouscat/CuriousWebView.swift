//
//  CuriousWebView.swift
//  Curiouscat
//
//  Created by Harry Twan on 2018/5/26.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import KVOController

public class CuriousWebView: UIView {
    
    private(set) var pageType: CuriousConfig.PageType
    
    private(set) var rootUrl: String
    
    private let eps: Double = 1e-4

    /// 点击非同类链接回调
    public var clickOtherLinks: ((CuriousConfig.PageType, String) -> Void) = { _,_ in }
    
    /// 加载完之后带高度的回调
    public var loadEndCallback: (Float) -> Void = { _ in }
    
    /// 是否可滑动
    public var isScrollEnabled: Bool = true {
        didSet {
            webView.scrollView.isScrollEnabled = isScrollEnabled
        }
    }
    
    /// 进度条颜色
    public var progressTintColor: UIColor = UIColor.blue {
        didSet {
            progressView.backgroundColor = progressTintColor
        }
    }
    
    lazy private var webView: WKWebView = {
        let wkConfig = WKWebViewConfiguration()
        
        let wkPreferences = WKPreferences()
        wkPreferences.javaScriptEnabled = true
        
        let wkUserContentController = WKUserContentController()
        
        if let userScript = CuriousConfig.loadUserScript(with: .githubMarkdown) {
            wkUserContentController.addUserScript(userScript)
        }
        
        wkConfig.userContentController = wkUserContentController
        wkConfig.preferences = wkPreferences

        var webView = WKWebView.init(frame: .zero, configuration: wkConfig)
        
        webView.isOpaque = false
        webView.backgroundColor = CuriousConfig.Colors.backColor
        webView.navigationDelegate = self
        return webView
    }()
    
    
    lazy private var progressView: UIProgressView = {
        var progressView = UIProgressView()
        progressView.backgroundColor = progressTintColor
        progressView.transform = CGAffineTransform.init(scaleX: 1.0, y: 1.5)
        return progressView
    }()
    
    override init(frame: CGRect) {
        self.pageType = .other
        self.rootUrl = "https://desgard.com/"
        super.init(frame: frame)
        initialViews()
        initialLayouts()
        load()
    }
    
    public init(type: CuriousConfig.PageType, url: String) {
        self.pageType = type
        self.rootUrl = url
        super.init(frame: .zero)
        initialViews()
        initialLayouts()
        load()
    }

    private func initialViews() {
        addSubview(webView)
        addSubview(progressView)
        
        kvoController.observe(webView, keyPath: "estimatedProgress", options: .new) {
            _, _, _ in
            let progress = self.webView.estimatedProgress
            self.progressView.progress = Float(progress)
            if fabs(Double(progress) - 1) < self.eps {
                UIView.animate(withDuration: 0.2) {
                    self.progressView.alpha = 0
                }
            } else {
                UIView.animate(withDuration: 0.2) {
                    self.progressView.alpha = 1
                }
            }
        }
    }
    
    private func initialLayouts() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }


    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - API
extension CuriousWebView {
    
    public func load() {
        if let url = URL(string: rootUrl) {
            webView.load(URLRequest(url: url))
        }
    }
    
    public func reload() { webView.reload() }
    
    public func back() { webView.goBack() }
    
    public func forward() { webView.goForward() }
    
    public var canBack: Bool {
        get { return webView.canGoBack }
    }
    
    public var canForward: Bool {
        get { return webView.canGoForward }
    }
    
    public func load(url: URL) {
        webView.load(URLRequest.init(url: url))
    }
}

// MARK: - WKNavigationDelegate
extension CuriousWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let urlText = webView.url?.absoluteString else {
            clickOtherLinks(.other, "")
            webView.stopLoading()
            return
        }
        let linkPageType = CuriousConfig.getUrlType(with: urlText)
        if linkPageType == pageType {
            print("Go to: \(urlText)")
        } else {
            webView.stopLoading()
            clickOtherLinks(linkPageType, urlText)
        }
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.body.scrollHeight") { height, _ in
            if let height: Float = height as? Float {
                print("height: \(height)")
                self.loadEndCallback(height)
            }
        }
    }
}
