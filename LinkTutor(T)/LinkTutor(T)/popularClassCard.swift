import SwiftUI

struct popularClassCard: View{
    var classData : classMockData
        var iconName: String
//    @State private var colorIndex: Int = 0
//    func getRandomColor() -> Color {
//        let colors: [Color] = [Color("#FFB703"), Color("#14CC92"), Color("#F4AAD5"), Color("#FFA138"), Color("#0ABAFF")]
//        if colorIndex == 4 {
//            colorIndex = 0
//        } else {
//            colorIndex += 1
//        }
//        print(colors[colorIndex])
//        return colors[colorIndex]
//    }
    var body: some View{
        VStack {
        //class
            Text("\(classData.skillType)")
                .font(AppFont.mediumSemiBold)
                .scaledToFit() // this will allow app to shrink
                .minimumScaleFactor(0.6)
            
        //tutor
            Text("by \(classData.studentsData.diffClassType.tutorName)")
                .font(AppFont.smallReg)
                .scaledToFit() // this will allow app to shrink
                .minimumScaleFactor(0.6)
                
        //icon
            Image("\(iconName)")
                .resizable()
                .frame(width: 40, height: 40)
            
        }
        .frame(width: 160, height: 180)
        .background(Color.accent)
        .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
        .cornerRadius(20)
        
        
        
        
    }
}

#Preview {
    popularClassCard(classData: classesMockData.sampleClassData, iconName: "book")
}
