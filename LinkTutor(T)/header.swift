import SwiftUI

struct header: View{
    var yourName: String
    @ObservedObject var teacherViewModel = TeacherViewModel.shared
    
    var body: some View{
        NavigationStack {
            VStack(alignment: .leading){
                HStack{
                    HStack{
                        Text("Hi")
                        Text(yourName)
                    }
                    .foregroundColor(.black)
                    .font(AppFont.largeBold)
                    Spacer()
                    NavigationLink(destination: myProfileView()){
                        if let imageUrl = teacherViewModel.teacherDetails.first?.imageUrl {
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image
                                    .resizable()
                                    .clipped()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(50)
                                    .padding(.trailing, 5)
                            } placeholder: {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .clipped()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(50)
                                    .padding(.trailing, 5)
                                    .foregroundStyle(Color.gray)
                            }
                            .frame(width: 90, height: 90)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .clipped()
                                .frame(width: 50, height: 50)
                                .cornerRadius(50)
                                .padding(.trailing, 5)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .offset(x:20)
                }
                Text("Ready to inspire minds today?")
                    .foregroundStyle(Color.black)
                    .font(AppFont.mediumReg)
                    .offset(y:-20)
//                Spacer()
            }
            .foregroundColor(.black)
        }
    }
}

//struct adding: View{
//    var body: some View{
//        
//    }
//}
//#Preview {
//    adding()
//}
#Preview {
        header(yourName: "Emma")
}
