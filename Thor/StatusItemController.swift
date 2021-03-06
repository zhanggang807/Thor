//
//  StatusItemController.swift
//  Thor
//
//  Created by Alvin on 5/12/16.
//  Copyright © 2016 AlvinZhu. All rights reserved.
//

import Cocoa
import Sparkle

class StatusItemController: NSObject, NSMenuDelegate {

    // MARK: Properties
    
    var statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var versionMenuItem: NSMenuItem!
    @IBOutlet weak var updateMenuItem: NSMenuItem!
    
    // MARK: NSMenuDelegate
    
    func menuWillOpen(_ menu: NSMenu) {
        versionMenuItem.title = NSApplication.formattedVersion()
    }
    
    // MARK: Actions
    
    @IBAction func showApps(_ sender: AnyObject) {
        if let rootViewController = SharedAppDelegate?.mainWindowController {
            rootViewController.showWindow(nil)
        } else {
            let rootViewController = NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil).instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: MainWindowController.classString)) as! MainWindowController
            SharedAppDelegate?.mainWindowController = rootViewController
            SharedAppDelegate?.mainWindowController?.showWindow(nil)
        }
        
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @IBAction func privacyPolicy(_ sender: Any) {
        NSWorkspace.shared.open(URL(string: "https://github.com/gbammc/Thor/blob/master/privacy.md")!)
    }
    
    @IBAction func quit(_ sender: AnyObject) {
        NSApp.terminate(self)
    }
    
    @IBAction func checkForUpdates(_ sender: AnyObject) {
        SUUpdater.shared().checkForUpdates(sender)
    }
    
    // MARK: Status bar
    
    func displayInStatusBar() {
        statusItem.image = NSImage(named: NSImage.Name("menu-item"))
        statusItem.menu = statusMenu
    }
    
}
