
import SwiftUI

struct TabBar: View {
    @State var currTabIndex = 0
    
    @State var inMiniplayer: String? = Optional.none

    @Namespace var animation

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom), content: {
            TabView(selection: $currTabIndex) {
                Files(search: "", inMiniplayer: $inMiniplayer)
                    .tag(0)
                    .tabItem {
                        // Find more symbols here: https://developer.apple.com/sf-symbols/release-notes/
                        Image(systemName: "rectangle.stack.fill")
                        Text("Files")
                    }
                Search()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                Text("Settings")
                    .tag(2)
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
            .onAppear {
                if #available(iOS 15.0, *) {
                    let appearance = UITabBarAppearance()
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            }

            Miniplayer(animation: animation, inMiniplayer: $inMiniplayer)
        })
    }
}
