import SwiftUI

struct reviewCard: View {
    var reviewRating: Int
    var review: String
    var time: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(String(repeating: "⭐️", count: reviewRating))")
                    .font(AppFont.actionButton)
                Spacer()
                Text("\(time)")
                    .font(AppFont.actionButton)
                    .foregroundStyle(.gray)
            }
            HStack {
                Text("\(review)")
                    .font(AppFont.smallReg)
                Spacer()
            }
            .padding([.top, .bottom], 5)
            Divider()
                .background(Color.elavated)
        }
    }
}

struct ReviewCard_Previews: PreviewProvider {
    static var previews: some View {
        reviewCard(reviewRating: 2, review: "Loved taking their classes!!", time: "20 March")
    }
}


