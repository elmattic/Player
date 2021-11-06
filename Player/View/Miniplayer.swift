
import SwiftUI
import AVFoundation

struct Miniplayer: View {
    var animation: Namespace.ID
    
    @Binding var expand: Bool
    
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
            Capsule()
                .fill(Color.gray)
                .frame(width: expand ? 60 : 0, height: expand ? 4 : 0)
                .opacity(expand ? 1 : 0)
                .padding(.top, 0)
                .padding(.vertical, expand ? 30 : 0)
            
            HStack(spacing: 15) {
                if expand {
                    Spacer(minLength: 0)
                }
                
                let author = inMiniplayer != nil ?
                    allObjects.first(where: { $0.id == inMiniplayer! })!.author : ""
                
                Text(expand ? author : String(author.prefix(1)))
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(width: expand ? height : 55, height: expand ? height : 55)
                    .background(Color.yellow, in: Rectangle())
                
                if !expand {
                    let title = inMiniplayer != nil ?
                        allObjects.first(where: { $0.id == inMiniplayer! })!.title : ""
                    
                    Text(title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .matchedGeometryEffect(id: "Label", in: animation)
                }
                
                Spacer(minLength: 0)
                
                if !expand {
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
            }
            .padding(.horizontal)
            
            VStack(spacing: 15) {
                Spacer(minLength: 0)
                
                HStack {
                    if expand {
                        let title = inMiniplayer != nil ?
                            allObjects.first(where: { $0.id == inMiniplayer! })!.title : ""
                        
                        Text(title)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: "Label", in: animation)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "ellipsis.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                }
                .padding()
                .padding(.top, 20)
                
                HStack {
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.7), Color.primary.opacity(0.1)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: 4)
                    
                    Text("PLAY")
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Capsule()
                        .fill(
                            LinearGradient(gradient: .init(colors: [Color.primary.opacity(0.1), Color.primary.opacity(0.7)]), startPoint: .leading, endPoint: .trailing)
                        )
                        .frame(height: 4)
                }
                .padding()
                
                Button(action: {
                    togglePlayPause()
                }, label: {
                    Image(systemName: self.isPlaying ? "play.fill" : "pause.fill")
                        .font(.largeTitle)
                        .foregroundColor(.primary)
                })
                .padding()
                
                Spacer(minLength: 0)
                
                HStack(spacing: 15) {
                    Image(systemName: "speaker.fill")
                    
                    Slider(value: $volume)
                    
                    Image(systemName: "speaker.wave.3.fill")
                }
                .padding()
                .padding(.bottom)
            }
            .frame(height: expand ? nil : 0)
            .opacity(expand ? 1 : 0)
        }
        .frame(maxHeight: expand ? .infinity : 80)
        .background(
            VStack(spacing: 0) {
                BlurView()
                
                Divider()
            }
            .onTapGesture(perform: {
                withAnimation(.spring()) {
                    expand = true
                }
            })
        )
        .cornerRadius(expand ? 20 : 0)
        .offset(y: expand ? 0 : -48)
        .offset(y: offset)
        .gesture(DragGesture().onEnded(onended(value:)).onChanged(onchanged(value:)))
        .ignoresSafeArea()
        .opacity(inMiniplayer != nil ? 1 : 0)
        .onChange(of: self.inMiniplayer) { value in
            let cid = allObjects.first(where: { $0.id == value! })!.cid
            loadCID(cid: cid)
            togglePlayPause()
        }
    }
    
    func onchanged(value: DragGesture.Value) {
        if value.translation.height > 0 && expand {
            offset = value.translation.height
        }
    }
    
    func onended(value: DragGesture.Value) {
        withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.95, blendDuration: 0.95)) {
            if value.translation.height > height {
                expand = false
            }
            
            offset = 0
        }
    }
}
