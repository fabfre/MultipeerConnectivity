//
//  ViewController.swift
//  Peer2PeerChatApp
//
//  Created by Fabian Frey on 17.04.18.
//  Copyright © 2018 Fabian Frey. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPCManagerDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var isAdvertising: Bool = false


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        appDelegate.mpcManager.delegate = self
        
        //@TODO start browsing for peers

        //@TODO start advertising the service provided by a local peer (to be visible for other peers)
        
        isAdvertising = true
    }
    
    @IBAction func startStopAdvertising(_ sender: Any) {
        let actionSheet = UIAlertController(title: "", message: "Change Visibility", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        var actionTitle: String
        if isAdvertising == true {
            actionTitle = "Make me invisible to others"
        }
        else{
            actionTitle = "Make me visible to others"
        }
        
        let visibilityAction: UIAlertAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default) { (alertAction) -> Void in
            if self.isAdvertising == true {
                // @TODO to be invisible for other peers

            }
            else {
                // @TODO to be visible for other peers
            }
            
            // change advertising property here
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            
        }
        
        actionSheet.addAction(visibilityAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // @TODO return here the right number (number of peers)
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellPeer") as! UITableViewCell
        //@TODO set text of the label to displayName of the right peer
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPeer = appDelegate.mpcManager.foundPeers[indexPath.row] as MCPeerID
        
        appDelegate.mpcManager.browser.invitePeer(selectedPeer, to: appDelegate.mpcManager.session, withContext: nil, timeout: 10)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func foundPeer() {
        //@TODO
    }
    
    
    func lostPeer() {
        //@TODO
    }
    
    func invitationWasReceived(fromPeer: String) {
        let alert = UIAlertController(title: "", message: "\(fromPeer) wants to chat with you.", preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Accept", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            // @TODO use the invitationHandler to accept the invitation
            
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            // @TODO decline the invitation

        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func connectedWithPeer(peerID: MCPeerID) {
        OperationQueue.main.addOperation { () -> Void in
            self.performSegue(withIdentifier: "goToChat", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

