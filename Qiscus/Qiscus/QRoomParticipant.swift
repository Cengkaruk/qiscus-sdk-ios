//
//  QRoomParticipant.swift
//  LinkDokter
//
//  Created by Qiscus on 2/24/16.
//  Copyright © 2016 qiscus. All rights reserved.
//

import UIKit
import RealmSwift

class QRoomParticipant: Object {
    dynamic var localId:Int = 0
    dynamic var participantRoomId:Int = 0
    dynamic var participantUserId:Int = 0
    dynamic var participantIsDeleted:Bool = false
    
    class var LastId:Int{
        get{
            let realm = try! Realm()
            let RetNext = realm.objects(QRoomParticipant).sorted("localId")
            
            if RetNext.count > 0 {
                let last = RetNext.last!
                return last.localId
            } else {
                return 0
            }
        }
    }
    
    override class func primaryKey() -> String {
        return "localId"
    }
    class func setDeleteAllParticipantInRoom(roomId:Int){
        let realm = try! Realm()
        var searchQuery = NSPredicate()
        
        searchQuery = NSPredicate(format: "participantRoomId == %d ", roomId)
        let participantData = realm.objects(QRoomParticipant).filter(searchQuery)
        
        if(participantData.count > 0){
            for participant in participantData{
                try! realm.write {
                    participant.participantIsDeleted = true
                }
            }
        }
    }
    class func addParticipant(userId:Int, roomId:Int){
        let realm = try! Realm()
        var searchQuery = NSPredicate()
        
        searchQuery = NSPredicate(format: "participantRoomId == %d AND participantUserId == %d", roomId, userId)
        let participantData = realm.objects(QRoomParticipant).filter(searchQuery)
        
        if(participantData.count > 0){
            let participant = participantData.first!
            try! realm.write {
                participant.participantIsDeleted = true
            }
        }else{
            let participant = QRoomParticipant()
            participant.localId = QRoomParticipant.LastId + 1
            participant.participantRoomId = roomId
            participant.participantUserId = userId
            try! realm.write {
                realm.add(participant)
            }
        }
    }
    class func CommitParticipantChange(roomId:Int){
        let realm = try! Realm()
        let searchQuery =  NSPredicate(format: "participantRoomId == %d AND participantIsDeleted == true", roomId)
        let participantData = realm.objects(QRoomParticipant).filter(searchQuery)
        
        if(participantData.count > 0){
            for participant in participantData{
                try! realm.write {
                    realm.delete(participant)
                }
            }
        }
    }
}
