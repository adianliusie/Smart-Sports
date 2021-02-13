//
//  Home.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 30/01/2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("background1"),Color("background2"),Color("background3")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView(.vertical){
                    Userbar()
                    Grid().padding(25)
                }
            }
        }
    }
}

struct Userbar: View {
    var body: some View {
        HStack{
            Text("Adian L.")
                .foregroundColor(.white)
                .font(.system(size:60, weight:.bold))
            Spacer()
            Image(systemName: "faceid")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.white)
        }
        .padding([.top, .leading, .trailing], 40)
        .navigationBarHidden(true)
    }
}
    
struct Grid: View {
    let items = Array(1...10)
    let layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        HStack{
            Spacer()
            LazyVGrid(columns: layout, content: {
                ForEach(sports, id:\.self){ sport in
                    NavigationLink(destination:SportPage(sport_data:sport)){
                        Square(image_name:sport.image_name, sport_name:sport.sport_name).padding(.vertical, 7)
                    }
                }
            })
            Spacer()
        }
    }
}

struct Square: View {
    let image_name: String
    let sport_name: String
    
    var body: some View {
        VStack{
            Image(image_name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 80.0, height: 80.0)
                .foregroundColor(.white)
                .padding(20)
                .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white, lineWidth: 4))
            Text(sport_name)
                .foregroundColor(.white)
                .font(.system(size:22, weight:.bold))
                .frame(width: 120)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
