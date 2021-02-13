//
//  Login.swift
//  Smart-Sports
//
//  Created by Adian Liusie on 30/01/2021.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LoginPage: View {
    @Binding var logged_in: Bool
    @State var index = 0
    @State var alert = false
    @State var error_message = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: .init(colors: [Color("background1"),Color("background2"),Color("background3")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack{
                login_type(index: $index)
                
                if self.index == 0 {
                    login(alert:$alert,
                          error_message:$error_message,
                          logged_in:$logged_in).padding()
                }
                else{
                    sign_up(alert:$alert,
                            error_message:$error_message,
                            logged_in:$logged_in).padding()
                }
                
                Image(systemName: "arkit")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150.0, height: 150.0)
                    .foregroundColor(.white)
                    .padding(30)
                
                guest_button(logged_in: $logged_in)
                
                Spacer()
            }
            if self.alert {
                ErrorView(alert:$alert, error_message:$error_message)
            }
        }
    }
}

struct guest_button: View {
    @Binding var logged_in: Bool

    var body: some View {
        Button(action: {
            self.logged_in.toggle()
        }) {
            Text("Continue as Guest")
                .foregroundColor(.white)
                .font(.system(size:22, weight:.bold))

        }
        .padding(.top, 20)

    }
}

struct login_type: View {
    @Binding var index: Int
    
    var body: some View {
        HStack{
            Button(action:{
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.3)){
                    self.index = 0
                }
            }){
                Text("Existing")
                    .foregroundColor(self.index == 0 ? .black : .white)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                
            }.background(self.index == 0 ? Color.white : Color.clear)
            .clipShape(Capsule())
            
            Button(action:{
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.3)){
                    self.index = 1
                }
            }){
                Text("New")
                    .foregroundColor(self.index == 1 ? .black : .white)
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .frame(width: (UIScreen.main.bounds.width - 50) / 2)
                
            }.background(self.index == 1 ? Color.white : Color.clear)
            .clipShape(Capsule())
        }
            .background(Color.black.opacity(0.4))
            .clipShape(Capsule())
            .padding(.top, 80)
    }
}

struct login: View {
    @Binding var alert: Bool
    @Binding var error_message: String
    @Binding var logged_in: Bool

    @State var mail = ""
    @State var pass = ""
    
    var body: some View {
        VStack{
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                  
                    TextField("Enter Email Address", text: self.$mail)
                    }.padding(.vertical, 10)
              
                Divider()
              
                HStack(spacing: 15){
                  
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                      
                    SecureField("Password", text: self.$pass)
                  
                    Button(action: {
                          
                    }) {
                          
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 10)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Button(action: {
                
            }) {
                Text("Forgotten Password?")
                    .foregroundColor(.white)
            }
            .padding(.top, 20)

            Button(action: {
                self.verify()
            }){
                Text("LOGIN")
                    .foregroundColor(.white)
                    .font(.system(size:26, weight:.bold))
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 180)
            }
            .background(Color("lightgreen"))
            .clipShape(Capsule())
            .padding(.top, 60.0)
        }
    }
    
    func verify(){
        if self.mail != "" && self.pass != ""{
            Auth.auth().signIn(withEmail: self.mail, password: self.pass) { (res, err) in
              
                if err != nil{
                  
                    self.error_message = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
              
                print("success")
                self.logged_in.toggle()
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else{
          
            self.error_message = "All fields must be filled"
            self.alert.toggle()
        }
    }
}

struct sign_up: View {
    @Binding var alert: Bool
    @Binding var error_message: String
    @Binding var logged_in: Bool

    @State var mail = ""
    @State var pass = ""
    @State var repass = ""

    var body: some View {
        VStack{
            VStack{
                HStack(spacing: 15){
                    Image(systemName: "envelope")
                        .foregroundColor(.black)
                  
                    TextField("Enter Email Address", text: self.$mail)
                    }.padding(.vertical, 10)
              
                Divider()
              
                HStack(spacing: 15){
                  
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                      
                    SecureField("Password", text: self.$pass)
                  
                    Button(action: {
                          
                    }) {
                          
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 10)
            
                Divider()

                HStack(spacing: 15){
                  
                    Image(systemName: "lock")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .foregroundColor(.black)
                      
                    SecureField("Re-enter Password", text: self.$repass)
                  
                    Button(action: {
                          
                    }) {
                          
                        Image(systemName: "eye")
                            .foregroundColor(.black)
                    }
                }.padding(.vertical, 10)
            }
            .padding(.vertical)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Button(action: {
                self.verify()
            }){
                Text("SIGN UP")
                    .foregroundColor(.white)
                    .font(.system(size:26, weight:.bold))
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 180)
            }
            .background(Color("lightgreen"))
            .clipShape(Capsule())
            .padding(.top, 51.2)
        }
    }
    
    private func add_user_firebase(){
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
                let uid = user.uid
                let db = Firestore.firestore()

                db.collection("users").document(uid).setData([
                    "email": self.mail,
                    "country": "USA"
                ]) { err in
                    if let err = err {
                        print("Error writing document: \(err)")
                    } else {
                        print("Document successfully written!")
                    }
                }
            }
        }
    }
    
    func verify(){
        if self.mail != ""{
            if self.pass == self.repass{
                 Auth.auth().createUser(withEmail: self.mail, password: self.pass) { (res, err) in
                    if err != nil{
                        self.error_message = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
              
                    print("success")
                    self.add_user_firebase()
                    self.logged_in.toggle()

                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else{
                self.error_message = "Passwords do not match"
                self.alert.toggle()
            }
        }
        else{
            self.error_message = "Email address must be provided"
            self.alert.toggle()
        }
    }
}

struct ErrorView: View{
    @Binding var alert: Bool
    @Binding var error_message: String
    
    var body: some View {
        GeometryReader{_ in
            HStack{
                Spacer()
                VStack{
                    Spacer()
                    VStack{
                        Text("Error")
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text("\(error_message)")
                            .padding(10)

                        Button(action: {
                            self.alert.toggle()
                        }){
                            Text("Ok")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 180)
                            }
                        .background(Color.red)
                        .cornerRadius(10)
                        .padding(.top, 10)
                    }
                    .padding(.vertical, 25)
                    .frame(width: UIScreen.main.bounds.width - 100)
                    .background(Color.white)
                    .cornerRadius(15)
                    Spacer()
                }
                Spacer()
            }
            }
         .background(Color.black.opacity(0.75).edgesIgnoringSafeArea(.all))

    }
}

struct test_preview: View {
    @State var logged_in = true
    
    var body: some View {
        LoginPage(logged_in: $logged_in)
    }
}
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        test_preview()
    }
}
