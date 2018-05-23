//
//  ChatViewViewController.swift
//  Peer2PeerChatApp
//
//  Created by Fabian Frey on 13.05.18.
//  Copyright © 2018 Fabian Frey. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPCMessagesDelegate, UITextFieldDelegate  {
    
    @IBOutlet weak var chatInput: UITextField!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let model: ChatMessageModel = ChatMessageModel.shared
    
    
    @IBAction func sendMessage(_ sender: Any) {
        if let message = chatInput.text {
            let data = ["message": message]
            //@TODO send data to other peer
            
            //@TODO save message to model
            tableView.reloadData()
            chatInput.text = ""
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(Notification.Name(rawValue: "newMessage"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.chatInput.delegate = self
        self.appDelegate.mpcManager.messageDelegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        //@TODO use the notification center to observe the model
        
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            bottomConstraint.constant = -(keyboardHeight)
        }
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        //handle dismiss of keyboard here
        bottomConstraint.constant = 0
    }
    
    @objc func newMessage(notification: NSNotification) {
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView.reloadData();
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func messageReceived() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.tableView.reloadData();
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        chatInput.resignFirstResponder()
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // @TODO return the right number
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath) as! ChatTableViewCell
        
        // @TODO set userNameLabel and userMessageLabel of the cell
        
        if model.chatMessages[indexPath.row].type == .own {
            cell.backgroundColorView.backgroundColor = UIColor.blue
            cell.userNameLabel.textAlignment = .right
            cell.userMessageLabel.textAlignment = .right
            cell.userMessageLabel.textColor = UIColor.white
            cell.userNameLabel.textColor = UIColor.white
        } else {
            cell.backgroundColorView.backgroundColor = UIColor.red
        }
        return cell
    }

}
