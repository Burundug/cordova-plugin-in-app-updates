import UIKit
@objc(InAppUpdate) class InAppUpdate : CDVPlugin {

    @objc(getUpdateAvailability:) func getUpdateAvailability(command: CDVInvokedUrlCommand){
        let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: false)
        commandDelegate.send(result, callbackId: command.callbackId)

    }

}


