//
//  SignUpView.swift
//  DesignCodeApp
//
//  Created by $@€€© on 9/28/22.
//

import SwiftUI

struct SignUpView: View {
    
    enum Field: Hashable{
        case email, password
    }
    
    @State var email = ""
    @State var password = ""
    @FocusState private var focusedField: Field?
    @State private var circleY: CGFloat = 0
    @State private var emailY: CGFloat = 0
    @State private var passwordY: CGFloat = 0
    @State private var circleColor: Color = .blue
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16){
                Text("Sign up")
                    .font(.largeTitle).bold()
                
                Text("Access 120+ hours of courses, tutorials and livestreams")
                    .font(.headline)
                
                TextField("Email", text: $email)
                    .inputStyle(icone: "mail")
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .email)
                    .shadow(color: focusedField == .email ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePrefrenceKey.self) { value in
                        emailY = value
                        circleY = value
                    }
                
                SecureField("Password", text: $password)
                    .inputStyle(icone: "lock")
                    .textContentType(.password)
                    .focused($focusedField, equals: .password)
                    .shadow(color: focusedField == .password ? .primary.opacity(0.3) : .clear, radius: 10, x: 0, y: 3)
                    .overlay(geometry)
                    .onPreferenceChange(CirclePrefrenceKey.self) { value in
                        passwordY = value
                    }
                
                Button {} label: {
                    Text("Create an account")
                        .frame(maxWidth: .infinity)
                }
                .font(.headline)
                .blendMode(.overlay)
                .buttonStyle(.angular)
                .tint(.blue)
                .controlSize(.large)
                
                Group {
                    Text("By clicking on ")
                    + Text("_Create an account_")
                        .foregroundColor(.primary.opacity(0.7))
                    + Text(", you agree to our **Terms of Service** and **[Privacy Policy](https://github.com/SaeedNoshadi89/DesignCodeApp)**")
                    
                    Divider()
                    
                    HStack{
                        Text("Already have an account?")
                        Button{} label: {
                            Text("**Sign in**")
                        }
                    }
                }
                .font(.footnote)
                .foregroundColor(.secondary)
                //                .accentColor(.secondary)
                
            }
            .padding(20)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
            .background(
                Circle()
                    .fill(circleColor)
                    .frame(width: 68, height: 68)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .offset(y: circleY)
            )
            .coordinateSpace(name: "container")
            .strokeStyle(cornerRadius: 30)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
            .padding(20)
            .background(
                Image("Blob 1").offset(x:220, y: -100)
            )
            .onChange(of: focusedField){ value in
                withAnimation{
                    if value == .email{
                        circleY = emailY
                        circleColor = .blue
                    }else{
                        circleY = passwordY
                        circleColor = .red
                    }
                }
            }
        }
    }
    
    var geometry: some View{
        GeometryReader{proxy in
            Color.clear.preference(key: CirclePrefrenceKey.self,
                                   value: proxy.frame(in: .named("container")).minY)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SignUpView()
        }
    }
}
