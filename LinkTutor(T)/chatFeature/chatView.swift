//
//  chatView.swift
//  LinkTutor(T)
//
//  Created by admin on 02/04/24.
//

import SwiftUI

class ChatViewModel: ObservableObject{
    @Published var messages = [Message]()
    
    
}


struct chatView: View {
    @StateObject var chatViewModel = ChatViewModel()
    @State var text = ""
    
    var body: some View {
        VStack{
            ScrollView{
                VStack(spacing: 8){
                    
                }
            }
            HStack{
                TextField("Hello", text: $text, axis: .vertical)
                    .padding()
                Button{
                    print("send")
                } label: {
                    Text("send")
                }
            }
        }
    }
}

#Preview {
    chatView()
}
