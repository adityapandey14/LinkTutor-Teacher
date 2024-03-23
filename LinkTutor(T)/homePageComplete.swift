//
//  homePageComplete.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 14/03/24.
//

import SwiftUI

struct homePageComplete: View {
    var body: some View {
    NavigationStack {
        TabView {
            TeacherHomePage()
                .tabItem {
                    Label("Home", systemImage: "house")
                        .padding(.top)
                }
            
            CalendarView()
                .tabItem {
                    Label("My Timetable" , systemImage: "calendar")
                }
            
            RequestList()
                .tabItem {
                    Label("Request" , systemImage: "cloud.fill")
                }
        }
        .accentColor(Color.accent)
    }
    .tint(Color.accent)
    .accentColor(Color.accent)
    //.navigationBarHidden(false)
    .preferredColorScheme(.dark)
}
}


#Preview {
    homePageComplete()
}
