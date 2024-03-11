//
//  AuthViewModel.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 12/03/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage


protocol AuthenticationFormProtocol {
    var FormIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    
    // This is firebaseAuth user
    @Published var userSession : FirebaseAuth.User?
    
    
    // This is our user
    @Published var currentUser: User?
    
    init() {
    self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email: String , password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email : String , password: String , fullName: String ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid , fullName: fullName, email: email)
            // here user store data which you can't store directly on the firebase you have to store in form of json like raw data format with key value pair
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("Teachers").document(user.id).setData(encodedUser)
            
            //This is how we got information uploaded to firebase
            //first we go to firestore.firestore then collection there we got user then we create document using user id then set all the data of the user
            await fetchUser()
            //we need to fetch user because the above code will upload data into firebase and it will take some time to upload
            //and it won't go to next line until that process is complete that is why we use await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut() //signOUt user on backened
            self.userSession = nil   //wipes out user session and teakes us back to login screen
            self.currentUser = nil   // wipes out current user data model
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() {
            Auth.auth().currentUser?.delete()
            self.userSession = nil
            self.currentUser = nil

        let userId = Auth.auth().currentUser!.uid

                Firestore.firestore().collection("Teachers").document(userId).delete() { err in
                    if let err = err {
                        print("error: \(err)")
                    } else {
                        print("Deleted user in db users")
                        Storage.storage().reference(forURL: "gs://myapp.appspot.com").child("users").child(userId).delete() { err in
                            if let err = err {
                                print("error: \(err)")
                            } else {
                                print("Deleted User image")
                                Auth.auth().currentUser!.delete { error in
                                   if let error = error {
                                       print("error deleting user - \(error)")
                                   } else {
                                        print("Account deleted")
                                   }
                                }
                            }
                        }
                    }
                }
    }
    func changePassword(password : String) {
        Task{
            
            await fetchUser()
        }
       Auth.auth().currentUser?.updatePassword(to: password) { err in
            if let err = err {
                print("error: \(err)")
            } else {
                print("Password has been updated")
                self.signOut()
            }
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //If there is data it will go and fetch data if there is not then it will return will wasting api calls
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        
        
       // print("DEBUG: Current user is \(String(describing: self.currentUser))")
    }
    
    //To add Course Data
     func addCourseData(skillType: String, academyName: String, className: String, mode: String, fees: String, week: [String], startTime: String, endTime: String, teacherUid: String) {
        
         let skill = skillType.lowercased()
         let db = Firestore.firestore()
         
         // Create a dictionary representing the data to be added
         let data: [String: Any] = [
             "academy": academyName,
             "className": className,
             "mode": mode,
             "skillUid" : skillType ,
             "fees": fees,
             "week": week,
             "startTime": startTime,
             "endTime": endTime,
             "teacherUid": teacherUid
         ]
         
         // Add the document to the "skillType" collection with skillType as the document ID
         db.collection("skillType").document(skill).collection("skillOwnerDetails").document("5").setData(data) { error in
             if let error = error {
                 print("Error adding document: \(error.localizedDescription)")
             } else {
                 print("Document added successfully to skillType collection with ID: \(skillType)")
             }
         }
     }
 
    
}

