//
//  skillType.swift
//  LinkTutor(T)
//
//  Created by Aditya Pandey on 12/03/24.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

// Define your data models
struct SkillType: Identifiable, Equatable {
    var id: String
    var skillOwnerDetails: [SkillOwnerDetail] = []
    var isAscendingOrder: Bool = true
    
    static func == (lhs: SkillType, rhs: SkillType) -> Bool {
        return lhs.id == rhs.id
    }
}

struct SkillOwnerDetail: Identifiable, Codable , Equatable {
    var id: String
    var academy: String
    var className: String
    var documentUid: String
    var price: Double
    var skillUid: String
    var teacherUid: String
    var week :  [String]
    var startTime : Timestamp
    var endTime : Timestamp
    var mode : String
    
    
}

// Create a view model to fetch the data
class SkillViewModel: ObservableObject {
    @EnvironmentObject var viewModel: AuthViewModel
    @Published var skillTypes: [SkillType] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchSkillTypes()
    }
    
    func fetchSkillTypes() {
        let db = Firestore.firestore()
        db.collection("skillType").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching skill types: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No skill types found")
                return
            }
            
            self.skillTypes = documents.map { document in
                SkillType(id: document.documentID)
            }
        }
    }
    
    
    func sortDetailsAscending(for skillType: SkillType) {
        if let index = skillTypes.firstIndex(where: { $0.id == skillType.id }) {
            skillTypes[index].skillOwnerDetails.sort { $0.price < $1.price }
            skillTypes[index].isAscendingOrder = true
        }
    }

    func sortDetailsDescending(for skillType: SkillType) {
        if let index = skillTypes.firstIndex(where: { $0.id == skillType.id }) {
            skillTypes[index].skillOwnerDetails.sort { $0.price > $1.price }
            skillTypes[index].isAscendingOrder = false
        }
    }
    
    
    func fetchSkillOwnerDetails(for skillType: SkillType) {
        let db = Firestore.firestore()
        db.collection("skillType").document(skillType.id).collection("skillOwnerDetails").getDocuments { querySnapshot, error in
            if let error = error {
                print("Error fetching skill owner details: \(error.localizedDescription)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                print("No skill owner details found")
                return
            }
            
            let details = documents.compactMap { document -> SkillOwnerDetail? in
                let data = document.data()
                return SkillOwnerDetail(
                    id: document.documentID,
                    academy: data["academy"] as? String ?? "",
                    className: data["className"] as? String ?? "",
                    documentUid: data["documentUid"] as? String ?? "",
                    price: data["price"] as? Double ?? 0,
                    skillUid: data["skillUid"] as? String ?? "",
                    teacherUid: data["teacherUid"] as? String ?? "",
                    week: data["week"] as? [String] ?? [],
                    startTime: data["startTime"] as? Timestamp ?? Timestamp(), // Default value if conversion fails
                    endTime: data["endTime"] as? Timestamp ?? Timestamp(), // Default value if conversion fails
                    mode: data["mode"] as? String ?? ""
                )
            }
            
            DispatchQueue.main.async {
                if let index = self.skillTypes.firstIndex(where: { $0.id == skillType.id }) {
                    self.skillTypes[index].skillOwnerDetails = details
                }
            }
        }
    }
    
   
    
    func deleteOwnerDetails() async {
        let db = Firestore.firestore()
        
        Task{
             fetchSkillTypes()
            await viewModel.fetchUser()
        }
        let userId = Auth.auth().currentUser!.uid
        
        db.collection("skillType").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching skill types: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No skill types found")
                return
            }
            
            for document in documents {
                db.collection("skillType").document(document.documentID).collection("skillOwnerDetails").getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error fetching skill owner details: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let detailsDocuments = querySnapshot?.documents else {
                        print("No skill owner details found")
                        return
                    }
                    
                    let details = detailsDocuments.compactMap { document -> SkillOwnerDetail? in
                        let data = document.data()
                        return SkillOwnerDetail(
                            id: document.documentID,
                            academy: data["academy"] as? String ?? "",
                            className: data["className"] as? String ?? "",
                            documentUid: data["documentUid"] as? String ?? "",
                            price: data["price"] as? Double ?? 0,
                            skillUid: data["skillUid"] as? String ?? "",
                            teacherUid: data["teacherUid"] as? String ?? "",
                            week: data["week"] as? [String] ?? [],
                            startTime: data["startTime"] as? Timestamp ?? Timestamp(), // Default value if conversion fails
                            endTime: data["endTime"] as? Timestamp ?? Timestamp(), // Default value if conversion fails
                            mode: data["mode"] as? String ?? ""
                        )
                    }
                    
                    DispatchQueue.main.async {
                        for detail in details where detail.teacherUid == userId {
                            db.collection("skillType").document(document.documentID)
                                .collection("skillOwnerDetails").document(detail.id).delete() { error in
                                    if let error = error {
                                        print("Error deleting document: \(error.localizedDescription)")
                                    } else {
                                        print("Document deleted successfully")
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
//end of the funtion
    
    
    func deleteOwnerDetails(documentId: String) async {
        let db = Firestore.firestore()
        
        Task {
             fetchSkillTypes()
            await viewModel.fetchUser()
        }
        let userId = Auth.auth().currentUser!.uid
        
        db.collection("skillType").getDocuments { snapshot, error in
            if let error = error {
                print("Error fetching skill types: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else {
                print("No skill types found")
                return
            }
            
            for document in documents {
                db.collection("skillType").document(document.documentID).collection("skillOwnerDetails").getDocuments { querySnapshot, error in
                    if let error = error {
                        print("Error fetching skill owner details: \(error.localizedDescription)")
                        return
                    }
                    
                    guard let detailsDocuments = querySnapshot?.documents else {
                        print("No skill owner details found")
                        return
                    }
                    
                    let details = detailsDocuments.compactMap { document -> SkillOwnerDetail? in
                        let data = document.data()
                        return SkillOwnerDetail(
                            id: document.documentID,
                            academy: data["academy"] as? String ?? "",
                            className: data["className"] as? String ?? "",
                            documentUid: data["documentUid"] as? String ?? "",
                            price: data["price"] as? Double ?? 0,
                            skillUid: data["skillUid"] as? String ?? "",
                            teacherUid: data["teacherUid"] as? String ?? "",
                            week: data["week"] as? [String] ?? [],
                            startTime: data["startTime"] as? Timestamp ?? Timestamp(), // Default value if conversion fails
                            endTime: data["endTime"] as? Timestamp ?? Timestamp(), // Default value if conversion fails
                            mode: data["mode"] as? String ?? ""
                        )
                    }
                    
                    DispatchQueue.main.async {
                        for detail in details where detail.teacherUid == userId && detail.id == documentId {
                            db.collection("skillType").document(document.documentID)
                                .collection("skillOwnerDetails").document(detail.id).delete() { error in
                                    if let error = error {
                                        print("Error deleting document: \(error.localizedDescription)")
                                    } else {
                                        print("Document deleted successfully")
                                    }
                                }
                        }
                    }
                }
            }
        }
    }


}



struct skillTypeView: View {
    @ObservedObject var viewModel = SkillViewModel()
    @State private var selectedSkillType: SkillType?
    let userId = Auth.auth().currentUser?.uid
    
    var body: some View {
        ScrollView {
            
            ForEach(viewModel.skillTypes) { skillType in
                VStack(alignment: .leading) {
                    Text("Skill Type: \(skillType.id)")
                        .font(.headline)
                        .onTapGesture {
                            selectedSkillType = skillType
                            viewModel.fetchSkillOwnerDetails(for: skillType)
                        }
                        .padding()
                    
                  
                    
                    ForEach(skillType.skillOwnerDetails.filter { $0.teacherUid == userId  }) { detail in
                        VStack(alignment: .leading) {
                            Text("Class Name: \(detail.className)")
                                .padding()
                            Text("Academy: \(detail.academy)")
                                .padding()
                            Text("Price: \(detail.price)")
                                .padding()
                            Text("week: \(detail.week)")
                                .padding()
                                .foregroundColor(.red)
                            

                        }
                    }
                }
                .padding()
            }
        }
    }
}




#Preview {
    skillTypeView()
}
