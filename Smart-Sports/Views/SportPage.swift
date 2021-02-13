//
//  SportPage.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 31/01/2021.
//

import SwiftUI

struct SportPage: View {
    var sport_data: Sport_Info
    @State var index = 0
    let description = "For this challenge you have 1 minute to try to hit the cross bar as many times as you can. Do you think you have what it takes to bend it like Beckham?"
    
    let challenge_name = "Cross Bar Challenge"
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("background1"),Color("background2"),Color("background3")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            ScrollView(.vertical){
                VStack{
                    Text(sport_data.sport_name.uppercased())
                        .font(.system(size:50, weight:.bold))
                        .foregroundColor(Color.white)
                        .padding([.leading, .bottom, .trailing], 20)
                    Challenge(index:$index,identifier:1, challenge_name:challenge_name, description:description)
                    Challenge(index:$index,identifier:2, challenge_name:challenge_name, description:description)
                    Challenge(index:$index,identifier:3, challenge_name:challenge_name, description:description)
                    Challenge(index:$index,identifier:4, challenge_name:challenge_name, description:description)
                    Challenge(index:$index,identifier:5, challenge_name:challenge_name, description:description)
                }
            }
        }
    }
}

struct Challenge: View {
    @Binding var index : Int
    let identifier : Int
    let challenge_name : String
    let description : String
    
    var body: some View {
        if self.index == identifier {
            VStack{
                HStack{
                    Text(challenge_name)
                        .font(.system(size:28, weight:.bold))
                    Spacer()
                    Button(action:{
                        withAnimation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 0.0)){
                        self.index = 0
                        }
                    }){
                        Image(systemName: "chevron.up")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20.0, height: 20.0)
                            .foregroundColor(.black)
                    }
                }.padding(20)
                
                Text(description)
                    .padding([.leading, .bottom, .trailing], 20)
                Image("football_targets")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width - 90)
                    .border(Color.black, width: 4)
                    .padding(.bottom, 20.0)
            }
            .frame(width: (UIScreen.main.bounds.width - 50))
            .background(Color("background0"))
            .cornerRadius(20)
        }
        else{
            HStack{
                Text(challenge_name)
                    .font(.system(size:28, weight:.bold))
                Spacer()
                Button(action:{
                    withAnimation(.spring(response: 0.4, dampingFraction: 1.0, blendDuration: 0.0)){
                        self.index = identifier
                    }
                }){
                    Image(systemName: "chevron.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20.0, height: 20.0)
                        .foregroundColor(.black)
                }
            }
            .padding(20)
            .frame(width: (UIScreen.main.bounds.width - 50))
            .background(Color.white)
            .cornerRadius(20)
        }
    }
}

struct SportPage_Previews: PreviewProvider {
    static var previews: some View {
        SportPage(sport_data:sports[0])
    }
}
