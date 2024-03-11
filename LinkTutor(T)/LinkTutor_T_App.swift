//
//  LinkTutor_T_App.swift
//  LinkTutor(T)
//
//  Created by user2 on 27/02/24.
//

import SwiftUI
import Firebase

@main
struct LinkTutor_T_App: App {
    @StateObject var viewModel = AuthViewModel()
   // @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    init(){
        FirebaseApp.configure()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.selectionIndicatorTintColor = UIColor.green
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }

    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
