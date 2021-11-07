
import SwiftUI
import AVFoundation

struct Miniplayer: View {
    var animation: Namespace.ID

    @Binding var inMiniplayer: String?

    @State var volume: CGFloat = 0

    @State var offset: CGFloat = 0

    @State var player: AVPlayer = AVPlayer()

    @State var isPlaying = false

    var height = UIScreen.main.bounds.height / 3

    func loadCID(cid: String) {
        // Gateway is temporary, the app will make use of ipfs-embed
        let gateway = "ipfs.chainsafe.io"
        let url = URL(string: "https://\(gateway)/ipfs/\(cid)")!
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
        player.volume = 1.0
    }

    func togglePlayPause() {
        let status = player.timeControlStatus
        if status == .paused {
            isPlaying = true
            play()
        }
        else if status == .playing {
            isPlaying = false
            player.pause()
        }
    }

    private func play() {
//        player.automaticallyWaitsToMinimizeStalling = false
//        player.playImmediately(atRate: 1.0)
        player.play()
    }

    var body: some View {
        VStack {
            HStack(spacing: 15) {
                let author = inMiniplayer != nil ?
                    allObjects.first(where: { $0.id == inMiniplayer! })!.author : ""

                Text(String(author.prefix(1)))
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(width: 55, height: 55)
                    .background(Color.yellow, in: Rectangle())

                let title = inMiniplayer != nil ?
                    allObjects.first(where: { $0.id == inMiniplayer! })!.title : ""

                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .matchedGeometryEffect(id: "Label", in: animation)

                Spacer(minLength: 0)

                Button(action: {
                    togglePlayPause()
                }, label: {
                    Image(systemName: self.isPlaying ? "play.fill" : "pause.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
                Button(action: {}, label: {
                    Image(systemName: "forward.fill")
                        .font(.title2)
                        .foregroundColor(.primary)
                })
            }
            .padding(.horizontal)
        }
        .frame(maxHeight: 80)
        .cornerRadius(10)
        .offset(y: -48)
        .offset(y: offset)
        .ignoresSafeArea()
        .opacity(inMiniplayer != nil ? 1 : 0)
        .onChange(of: self.inMiniplayer) { value in
            let cid = allObjects.first(where: { $0.id == value! })!.cid
            loadCID(cid: cid)
            togglePlayPause()
        }
    }
}
