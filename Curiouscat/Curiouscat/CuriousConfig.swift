//
//  CuriousConfig.swift
//  Curiouscat
//
//  Created by Harry Twan on 2018/5/26.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import WebKit
import Alamofire

public class CuriousConfig {
    
    static let SCRIPT_URL = "https://raw.githubusercontent.com/Sepicat/Curiouscat/master/Curiouscat/Curiouscat/js/github-markdown.js"
    
    public enum PageType: Int {
        case githubMarkdown
        case githubCode
        case other
    }
    
    public class Colors {
        static public var backColor: UIColor = UIColor(rgbString: "#3C3836")
        static public var textShowColor: UIColor = UIColor(rgbString: "#d5c4a1")
        static public var textLinkColor: UIColor = UIColor(rgbString: "#b8bb26")
        static public var textBlockQuoteColor: UIColor = UIColor(rgbString: "#d5c4a1")
    }
    
    static let shared: CuriousConfig = CuriousConfig()
    
    /// 根据类型获取注入 js 脚本
    static func loadUserScript(with type: PageType) -> WKUserScript? {
        // 从网络获取注入 js 脚本
        Alamofire.request(SCRIPT_URL, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
            .responseString { resp in
                switch resp.result {
                case .success(let script):
                    print(script)
                case .failure(let error):
                    print(error.localizedDescription)
                }
        }
        
        // 本地降级注入逻辑
        guard let path = Bundle.main.path(forResource: type.scriptName, ofType: "js") else {
            return nil
        }

        do {
            let scriptTemplete = try String(contentsOfFile: path, encoding: .utf8)
            
            print(Colors.backColor.r(), Colors.backColor.g(), Colors.backColor.b())
            
            let script = String(format: scriptTemplete,
                                Colors.backColor.hex(),
                                Colors.textShowColor.hex(),
                                Colors.textLinkColor.hex(),
                                Colors.textBlockQuoteColor.hex())
            
            return WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        }
        catch {
            print("Cannot load file")
            return nil
        }
    }
    
    /// 根据 URL 判断 PageType
    static func getUrlType(with url: String) -> PageType {
        if url.hasPrefix("https://github.com")
            && (url.hasSuffix(".md") || url.hasSuffix(".markdowm")) {
            return .githubMarkdown
        }
        return .other
    }

    // reset 颜色主题，恢复 gruvbox
    static func resetColors() {
        Colors.backColor = UIColor(rgbString: "#3C3836")
        Colors.textShowColor = UIColor(rgbString: "#d5c4a1")
        Colors.textLinkColor = UIColor(rgbString: "#b8bb26")
        Colors.textBlockQuoteColor = UIColor(rgbString: "#d5c4a1")
    }
}

public extension CuriousConfig.PageType {
    var scriptName: String {
        get {
            switch self {
            case .githubMarkdown:
                return "github-markdown"
            default:
                return ""
            }
        }
    }
}
