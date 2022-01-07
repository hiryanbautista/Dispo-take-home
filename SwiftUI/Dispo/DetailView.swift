import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    
    var gifID: String
    @EnvironmentObject var vm: GiphyViewModel
    
    var body: some View {
        VStack {
            if let gif = vm.gifDetail {
                VStack(spacing: 12) {
                    AnimatedImage(url: gif.images.fixed_height.url)
                        .resizable()
                        .scaledToFit()
                    Text(gif.title)
                    if let username = gif.username, !username.isEmpty {
                        Text("@\(username)")
                    }
                }
            }
        }
        .task {
            await vm.fetchById(id: gifID)
        }
        .onDisappear {
            vm.removeDetail()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(gifID: "eNijbUDblGutPSBmeq")
            .environmentObject(GiphyViewModel())
    }
}
