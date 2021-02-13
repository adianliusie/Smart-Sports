//
//  UserViewModel.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 13/02/2021.
//

import Foundation
import FirebaseFirestore

class UserViewModel: ObservableObject {
    @Published var name = "Edwin"
    @Published var score = [1,2,3,4]

    func test() -> Bool{
        return true
    }
}
