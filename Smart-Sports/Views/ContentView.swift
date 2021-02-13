//
//  ContentView.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 27/01/2021.
//

import SwiftUI
import Firebase


struct ContentView: View {
    @State var logged_in = false
    var body: some View {
        NavigationView{
            if !logged_in{
                LoginPage(logged_in:$logged_in)
            }
            else{
                Home()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
