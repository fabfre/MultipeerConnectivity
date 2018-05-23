//
//  ChatMessageModel.swift
//  Peer2PeerChatApp
//
//  Created by Fabian Frey on 13.05.18.
//  Copyright © 2018 Fabian Frey. All rights reserved.
//

import Foundation
import MultipeerConnectivity

enum ChatTyp {
    case own
    case foreign
}

struct ChatMessage {
    let message: String
    let peer: MCPeerID
    let type: ChatTyp
    
    init(message: String, peer: MCPeerID) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        self.message = message
        self.peer = peer
        
        if appDelegate.mpcManager.peer == peer {
            self.type = ChatTyp.own
        } else {
            self.type = ChatTyp.foreign
        }
    }
}

class ChatMessageModel {
    static let shared: ChatMessageModel = ChatMessageModel()
    
    var chatMessages: [ChatMessage] = []
    
    //creating new chat message
    func addMessage(message: String, peerName: MCPeerID) {
        let newChatMessage = ChatMessage.init(message: message, peer: peerName)
        // @TODO save new chat message
        
        //@TODO inform ChatViewController to update TableView

    }
}
