import UIKit
@objc(InAppUpdate) class InAppUpdate : CDVPlugin {

    @objc(getUpdateAvailability:) func getUpdateAvailability(command: CDVInvokedUrlCommand){
        self.commandDelegate.run(inBackground: {
            let status = self.newUpdates()
            let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: status)
            
            self.commandDelegate.send(result, callbackId: command.callbackId)
        })

    }
    
    func newUpdates() -> String{
        let infoDict = Bundle.main.infoDictionary! as NSDictionary
        
        let appId = infoDict.object(forKey: "CFBundleIdentifier") as! String
        let url = NSURL(string: String(format: "http://itunes.apple.com/lookup?bundleId=%@", appId))
        let data = NSData(contentsOf: url! as URL)
        
        do {
            let lookUp = try JSONSerialization.jsonObject(with: data! as Data, options: .mutableContainers) as? NSMutableDictionary
            if((lookUp?.object(forKey: "resultCount") as AnyObject).integerValue == 1){
                let appStoreVersion = ((lookUp?.object(forKey: "results") as AnyObject).object(at: 0) as AnyObject).object(forKey: "version") as! String
                let currentAppVersion = infoDict.object(forKey: "CFBundleShortVersionString") as! String
                if (appStoreVersion != currentAppVersion){
                    return "UPDATE_AVAILABLE";
                } else {
                    return "UPDATE_NOT_AVAILABLE";
                }
            }
            else{
                return "UPDATE_NOT_AVAILABLE";
            }
        } catch {
            return "UPDATE_NOT_AVAILABLE";
        }

    }
    
    @objc(updateImmediate:) func updateImmediate(command: CDVInvokedUrlCommand) {
        guard let appStoreURI = URL(string: "itms-apps://apps.apple.com/app/id1560625254?mt=8") else {
            return
        }
        guard let appStoreURL = URL(string: "https://apps.apple.com/ru/app/id1560625254?mt=8") else {
            return
        }
        if(UIApplication.shared.canOpenURL(appStoreURI)) {
            UIApplication.shared.open(appStoreURI)
        } else {
            if(UIApplication.shared.canOpenURL(appStoreURL)) {
                UIApplication.shared.open(appStoreURL)
            }
    
        }
    }
    

}


