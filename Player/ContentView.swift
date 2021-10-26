
import SwiftUI

struct ContentView: View {
    var body: some View {
        let result = rust_greeting("world")
        let swift_result = String(cString: result!)
        rust_greeting_free(UnsafeMutablePointer(mutating: result))
        return Text(swift_result)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
