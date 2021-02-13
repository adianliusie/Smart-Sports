//
//  Test.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 07/02/2021.
//

import SwiftUI

struct Test: View {
    @ObservedObject private var viewmodel = TestViewModel()

    // var users = testdata

    var body: some View {
        VStack{
            List(viewmodel.users) { user in
                Text("Hello \(user.email)")
                Text("From \(user.country)")
            }
            Button(action:{
                self.viewmodel.fetchData()
            }
            ){
                Text("refresh")
            }
        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
