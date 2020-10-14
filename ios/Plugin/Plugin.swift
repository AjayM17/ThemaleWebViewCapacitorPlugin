import Foundation
import Capacitor
import WebKit
/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */

protocol Action: AnyObject {
    func back(_ text: String)

}
@objc(CustomWebView)
public class CustomWebView: CAPPlugin,Action {
    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("param")
        let data = Data(value!.utf8)

        do {
            // make sure this JSON is in the format we expect
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                let url = json["url"] as! String
                let buttons = json["buttons"] as! [AnyObject]

                DispatchQueue.main.async {
                    let view = ViewScreenController()
                    view.delegate = self
                    view.button = buttons
                    view.url = url
                            let nav = UINavigationController(rootViewController: view)
                            nav.modalPresentationStyle = .fullScreen;
                            self.bridge.viewController.present(nav, animated: true, completion: nil)
                }
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
    }
    func back(_ text: String) {
        self.notifyListeners("myEvent",data: ["res":  "You Click " + text + " !"])
       }
}


class ViewScreenController: UIViewController {

    var button = [AnyObject]()
    var url = String()
    weak var delegate: Action?
    private let webView: WKWebView = {

        let configuration =  WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
            return webView
    }()
    
            override func viewDidLoad() {
                super.viewDidLoad()
                title = "welcome"
                view.backgroundColor = .systemBlue
                view.addSubview(webView)
                         let myURL = URL(string:url)
                             let myRequest = URLRequest(url: myURL!)
                             webView.load(myRequest)
                for (index,btn) in button.enumerated() {
                    createButton(text: btn["text"] as! String, index: index)
                }
                
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            webView.frame = view.bounds
        }
    
    
    func createButton(text:String,index:Int) {
        let y_pos =  view.frame.maxY
        let button = UIButton(frame: CGRect(x:( index * 100), y: (Int(y_pos) - 50) , width: 60, height: 30))
            button.setTitle(text,
            for: .normal)
            button.backgroundColor = .systemTeal
            button.setTitleColor(.systemRed, for: .normal)
            self.view.addSubview(button)
        button.tag = index
            button.addTarget(self, action: #selector(reply), for: .touchUpInside)
        }
        @objc private func reply(sender:UIButton){
//            if(sender.tag == 0){
            self.delegate?.back(button[sender.tag]["text"] as! String)
//                          self.dismiss(animated:true,completion:nil)
//            }
        }
    
    }

    


