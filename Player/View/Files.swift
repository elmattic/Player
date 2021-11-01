
import SwiftUI

struct Files: View {
    @State var search = ""
    
    @Binding var inMiniplayer: String?
    
    @Namespace var topID
    
    @Namespace var bottomID
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                HStack {
                    Text("Files")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.primary)
                    
                    Spacer(minLength: 0)
                }
                
                ForEach(allObjects) { object in
                    ObjectTab(object: object, inMiniplayer: $inMiniplayer)
                }
            }
            .padding()
        }
    }
}

struct ObjectTab: View {
    @State var object: Object
    
    @Binding var inMiniplayer: String?

    var body: some View {
        HStack(spacing: 15) {
            Text(String(object.author.prefix(1)))
                .font(.title3)
                .fontWeight(.bold)
                .frame(width: 40, height: 40)
                .background(Color.yellow, in: Rectangle())
            
            VStack(alignment: .leading, spacing: 8) {
                Text(object.title)
                    .font(.callout)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(object.cid)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onTapGesture(perform: {
            inMiniplayer = object.id
        })
    }
}
