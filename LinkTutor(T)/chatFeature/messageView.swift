//
//  messageView.swift
//  LinkTutor(T)
//
//  Created by admin on 02/04/24.
//

import SwiftUI

struct Message: Decodable{
    let userUid: String
    let text: String
    let photoURL: String
    let createdAt: Date
}

struct messageView: View {
    var message: Message
    var isFromCurrentUser: Bool = true
    
    
    var body: some View {
        if isFromCurrentUser{
            HStack{
                HStack{
                    Text(message.text)
                        .padding()
                }
                .frame(alignment: .leading)
                .background(.gray)
                .cornerRadius(20)
                
                Image(systemName: "person")
                    .padding(.bottom, 16)
                    .padding(.trailing, 4)
            }
        } else {
            HStack{
                Image(systemName: "person")
                    .padding(.bottom, 16)
                    .padding(.trailing, 4)
                    
                HStack{
                    Text(message.text)
                        .padding()
                }
                .frame(alignment: .leading)
                .background(.gray)
                .cornerRadius(20)
            }
        }
    }
}

struct messageView_Previews: PreviewProvider {
    static var previews: some View {
        messageView(message: Message(userUid: "123", text: "Hello", photoURL: " ", createdAt: Date()))
    }
}

