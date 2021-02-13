//
//  Home.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 30/01/2021.
//

import SwiftUI

struct Home2: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("background1"),Color("background2"),Color("background3")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            VStack{
                ScrollView(.vertical){
                    UserBar2()
                    SportSelection().padding(25)
                }
            }
        }
    }
}

struct UserBar2: View {
    @ObservedObject private var viewmodel = UserViewModel()

    var body: some View {
        HStack{
            Text("\(self.viewmodel.name)")
                .foregroundColor(.black)
                .font(.system(size:60, weight:.bold))
                .padding(.horizontal, 20.0)
            Spacer()
            Image(systemName: "faceid")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
        }
        .padding([.top, .leading, .trailing], 40)
    }
}
    
struct SportSelection: View {
    @ObservedObject private var viewmodel = UserViewModel()

    var body: some View {
        VStack{
            ForEach(sports, id:\.self){ sport in
                NavigationLink(destination:SportPage(sport_data:sport)){
                    SportBox(image_name:sport.image_name, sport_name:sport.sport_name).padding(.vertical, 7)
                }
            }
        }
    }
}

struct SportBox: View {
    let image_name: String
    let sport_name: String
    
    var body: some View {
        HStack{
            VStack{
                Image(image_name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80.0, height: 80.0)
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.white, lineWidth: 4))
                Text(sport_name)
                    .font(.system(size:22, weight:.bold))
                    .frame(width: 120)
            }
            Spacer()
            Text("10/21")
                .font(.system(size:50, weight:.bold))
                .frame(width: 150)
        }
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 16)
                .stroke(Color.black, lineWidth: 4))
        .padding(.horizontal,20)
    }
}

struct Home2_Previews: PreviewProvider {
    static var previews: some View {
        SportBox(image_name:"football", sport_name:"Football")
    }
}
