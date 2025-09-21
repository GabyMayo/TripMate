import SwiftUI
import WebKit

struct TravelResourcesView: View {
    @State private var videoURL: URL? = nil
    
    // Travel videos / resources
    let videos: [(title: String, url: String)] = [
        ("Packing Tips", "https://www.youtube.com/watch?v=4H4YNfh8K1Q"),
        ("Travel Safety", "https://www.youtube.com/watch?v=9fL6H2nGzT0"),
        ("Budget Travel", "https://www.youtube.com/watch?v=Ht6-BbJg9ys"),
        ("City Guide", "https://www.youtube.com/watch?v=aVf7u6Uy9jo"),
        ("Flight Hacks", "https://www.youtube.com/watch?v=H7b1aE1qlh0"),
        ("Hotel Tips", "https://www.youtube.com/watch?v=U1rU3GJwN3o")
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Travel Resources")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(videos, id: \.title) { video in
                    Button(video.title) {
                        videoURL = URL(string: video.url)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                }
            }
            .padding()
            
            if let url = videoURL {
                YouTubeWebView(videoURL: url)
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding()
            }
            
            Spacer()
        }
        .padding()
        .background(Color(red: 0.5, green: 0.78, blue: 0.8))
    }
}

struct YouTubeWebView: NSViewRepresentable {
    var videoURL: URL
    
    func makeNSView(context: Context) -> WKWebView { WKWebView() }
    
    func updateNSView(_ nsView: WKWebView, context: Context) {
        nsView.load(URLRequest(url: videoURL))
    }
}
