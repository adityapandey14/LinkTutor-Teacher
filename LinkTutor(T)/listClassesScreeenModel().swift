//
//  listClassesScreeenModel().swift
//  linkTutor
//
//  Created by user2 on 11/02/24.
//

import SwiftUI

final class listClassesScreenModel : ObservableObject {
    @Published var isShowingDetailView: Bool = false
    // this property needs to be published because we want our grid to be listening for when is showing View details view changes
    // when the isShowingViewDetail is changes to true then we are going to show the details
    
    
    
    var TeacherEnrolledClassFramework : TeacherEnrolledClasses?
    {
        didSet{
            isShowingDetailView = true
        }
    }
    
    var InputPageFramework : ProfileInputView?
    {
        didSet{
            isShowingDetailView = true
        }
    }
    
  
  
    init(isShowingDetailView: Bool = false) {
           self.isShowingDetailView = isShowingDetailView
       }
}
