//
//  CuriousConfig.swift
//  Curiouscat
//
//  Created by Harry Twan on 2018/5/26.
//  Copyright © 2018年 Harry Twan. All rights reserved.
//

import UIKit
import WebKit

public class CuriousConfig {
    
    public enum PageType: Int {
        case githubMarkdown
        case githubCode
        case other
    }
    
    public struct Colors {
        public var backColor: UIColor
        public var textShowColor: UIColor
        public var textLinkColor: UIColor
    }
    
    /// 根据类型获取注入 js 脚本
    static func loadUserScript(with type: PageType) -> WKUserScript? {
        guard let path = Bundle.main.path(forResource: type.scriptName, ofType: "js") else {
            return nil
        }
        
        do {
            let scriptTemplete = try String(contentsOfFile: path, encoding: .utf8)
            let script = String(format: scriptTemplete, "#3C3836", "#d5c4a1")
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
