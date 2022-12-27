//
//  WebViewController.swift
//  BridgeApp
//
//  Created by Franco Octavianus on 23/12/2022.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> WebViewController {
        WebViewController(nibName: nil, bundle: nil)
    }

    func updateUIViewController(_ uiViewController: WebViewController, context: Context) {

    }

}

final class WebViewController: UIViewController {

    weak var webView: WKWebView?

    override func loadView() {
        super.loadView()
        let webView = createWebView()
        view = webView
        self.webView = webView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let url = URL(string: "rapidai://index.html")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
        webView?.load(request)
    }

    private func createWebView() -> WKWebView {
        let preferences = WKPreferences()
        preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")

        let configuration = WKWebViewConfiguration()
//        configuration.setValue(true, forKey: "allowFileAccessFromFileURLs")
        configuration.setValue(true, forKey: "allowUniversalAccessFromFileURLs")
        configuration.preferences = preferences

        configuration.setURLSchemeHandler(RapidSchemeHandler(), forURLScheme: RapidSchemeHandler.urlScheme)

//        for entry in handlers {
//            configuration.setURLSchemeHandler(entry.schemeHandler,
//                                              forURLScheme: entry.urlScheme)
//        }

        let webView = WKWebView(frame: CGRect.zero, configuration: configuration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.scrollView.bounces = false
        webView.uiDelegate = self
        webView.navigationDelegate = self
//        webView.allowsBackForwardNavigationGestures
        return webView
    }
}

extension WebViewController: WKUIDelegate, WKNavigationDelegate {
    func webViewDidClose(_ webView: WKWebView) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, respondTo challenge: URLAuthenticationChallenge) async -> (URLSession.AuthChallengeDisposition, URLCredential?) {
        print("\(#file):\(#line) \(#function)")
        return (.performDefaultHandling, nil)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        print("\(#file):\(#line) \(#function)")
        return .allow
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
        print("\(#file):\(#line) \(#function)")
        print("  " + navigationResponse.response.description)
        return .allow
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, contextMenuConfigurationFor elementInfo: WKContextMenuElementInfo) async -> UIContextMenuConfiguration? {
        print("\(#file):\(#line) \(#function)")
        return nil
    }

    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, didBecome download: WKDownload) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences) {
        print("\(#file):\(#line) \(#function)")
        return (.allow, preferences)
    }

    func webView(_ webView: WKWebView, shouldAllowDeprecatedTLSFor challenge: URLAuthenticationChallenge) async -> Bool {
        print("\(#file):\(#line) \(#function)")
        return true
    }

    func webView(_ webView: WKWebView, navigationResponse: WKNavigationResponse, didBecome download: WKDownload) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, contextMenuDidEndForElement elementInfo: WKContextMenuElementInfo) {
        print("\(#file):\(#line) \(#function)")
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("\(#file):\(#line) \(#function)")
    }
}
