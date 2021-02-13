//
//  SportDataViewModel.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 07/02/2021.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable {
    var id = UUID().uuidString
    var email: String
    var country: String
    var best: Bool
}

let testdata = [
    User(email: "adianliusie@gmail.com", country:"UAE", best:true),
    User(email: "vyasraina@gmail.com", country:"UK", best:false)
]

class TestViewModel: ObservableObject{
    @Published var users = [User]()
    
    private var db = Firestore.firestore()
    
    func test() -> Bool{
        return true
    }
    
    func fetchData(){
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("no documents")
                return
            }
        
            self.users = documents.map { (queryDocumentSnapshot) -> User in
                let data = queryDocumentSnapshot.data()
                
                let email = data["email"] as? String ?? ""
                let country = data["country"] as? String ?? ""
                let best = data["best"] as? Bool ?? false
            
            print("refreshed")
            return User(email: email, country:country, best:best)
            }
        }
    }
}


