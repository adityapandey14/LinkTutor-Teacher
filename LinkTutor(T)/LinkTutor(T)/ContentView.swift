//
//  ContentView.swift
//  LinkTutor(T)
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            TeacherHomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
        }
    }
}

#Preview {
    ContentView()
}
