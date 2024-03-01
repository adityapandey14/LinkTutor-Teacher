import SwiftUI

struct enrolledClassDataM: Identifiable{
    var id = UUID()
    var className: String
    var skill : String
    var tutorName: String
    var daysConducted: String
    var timing: String
}


struct enrolledClassMockData {
    static let sampleClassData = enrolledClassDataM(className: "sampleName",
                                                    skill:  "SkillType" ,
                                                    tutorName: "sampleTutor",
                                                    daysConducted:  "anyDay",
                                                    timing: "4-5pm")
    
    static let classData = [
        enrolledClassDataM(className: "Aditya's Class",
                            skill:  "English" ,
                           
                                                        tutorName: "Aditya Pandey",
                                                        daysConducted:  "Monday",
                                                        timing: "4-5pm"),
        enrolledClassDataM(className: "Pardha's Class",
                           skill:  "Dance" ,
                                                        tutorName: "Pardha",
                                                        daysConducted:  "Tuesday",
                                                        timing: "2-3pm"),
        enrolledClassDataM(className: "Vikashini's Class",
                           skill:  "Hindi" ,
                                                        tutorName: "Vikashini",
                                                        daysConducted:  "Wednesday",
                                                        timing: "6-7pm"),
        enrolledClassDataM(className: "Ritwatz's Class",
                           skill:  "Guitar" ,
                                                        tutorName: "Ritwatz",
                                                        daysConducted:  "Friday",
                                                        timing: "5-6pm")
        
    
    
    ]
}
