//
//  Post.swift
//  FoodFeed
//
//  Created by Youssef Hammoud on 5/28/16.
//  Copyright © 2016 Appzaholic. All rights reserved.
//

import Foundation
import Firebase

class Post {
    private var _postRef: Firebase!
    
    private var _postKey: String!
    private var _postCaption: String!
    private var _postVotes: Int!
    private var _postImage: NSObjectFileImage!
    private var _username: String!
    
    var postKey: String {
        return _postKey
    }
    
    var postCaption: String {
        return _postCaption
    }
    
    var postVotes: Int {
        return _postVotes
    }
    
    var postImage: NSObjectFileImage {
        return _postImage
    }
    
    var username: String {
        return _username
    }
    
    // Initialize the new Joke
    
    init(key: String, dictionary: Dictionary<String, AnyObject>) {
        self._postKey = key
        
        // Within the Joke, or Key, the following properties are children
        
        if let votes = dictionary["votes"] as? Int {
            self._postVotes = votes
        }
        
        if let caption = dictionary["postCaption"] as? String {
            self._postCaption = caption
        }
        
        if let user = dictionary["author"] as? String {
            self._username = user
        } else {
            self._username = ""
        }
        
        // The above properties are assigned to their key.
        
        self._postRef = FirebaseService.firebaseService.POST_REF.childByAppendingPath(self._postKey)
    }
    
    func addSubtractVote(addVote: Bool) {
        
        if addVote {
            _postVotes = _postVotes + 1
        } else {
            _postVotes = _postVotes - 1
        }
        
        // Save the new vote total.
        
        _postRef.childByAppendingPath("votes").setValue(_postVotes)
        
    }

}
