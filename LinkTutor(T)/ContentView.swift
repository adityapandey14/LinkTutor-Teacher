//
//  ContentView.swift
//  LinkTutor(T)
//
//  Created by user2 on 27/02/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                homePageComplete()
            
            } else {
                loginView()
            }
        }
       
    }
}

#Preview {
    ContentView()
        .environmentObject(AuthViewModel())
        
}
