import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    
    let channelName : String = "Printing"
    
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
      
    return true
  }
    
    
    override func applicationDidFinishLaunching(_ notification : Notification) {
        let controller : FlutterViewController = mainFlutterWindow?.contentViewController as! FlutterViewController
        let channel = FlutterMethodChannel.init(name: channelName, binaryMessenger: controller.engine.binaryMessenger)
        channel.setMethodCallHandler({ (_ call: FlutterMethodCall, _ result: FlutterResult) -> Void in
                    if ( call.method == "encode") {
                        // Those values are guaranteed by the Dart code
                        let args = call.arguments as! [String:Any]
                        let data = args["data"] as! NSString
                        let encode = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(
                            CFStringConvertIANACharSetNameToEncoding("CP866" as CFString)
                        ))
                        
                        if let output = data.data(using: encode.rawValue) {
                            result(FlutterStandardTypedData.init(bytes: output))
                        }
                    }
                });
    }
    
}
