import SwiftUI

struct SegmentedPickerView: View {
    private let titles: [Any]
    @Binding private var selectedIndex: Int
    @State private var frames: Array<CGRect>
    
    init(titles: [String],
         selectedIndex: Binding<Int>)
    {
        self.titles = titles
        self._selectedIndex = selectedIndex
        self.frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }
    
    init(titles: [Image],
         selectedIndex: Binding<Int>)
    {
        self.titles = titles
        self._selectedIndex = selectedIndex
        self.frames = Array<CGRect>(repeating: .zero, count: titles.count)
    }
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(titles.indices, id: \.self) { index in
                        Button(action:{
                            withAnimation {
                                selectedIndex = index
                            }
                        })
                        {
                            _titlesBuilder(title: titles[index])
                                .frame(width: geometry.size.width / CGFloat(titles.count))
                                .foregroundColor(selectedIndex == index ? .black : .gray)
                        }
                        .background(
                            GeometryReader { geoReader in
                                Color.clear.preference(key: RectPreferenceKey.self, value: geoReader.frame(in: .global))
                                    .onPreferenceChange(RectPreferenceKey.self) {
                                        self.frames[index] = $0
                                    }
                            }
                        )
                    }
                }
                .modifier(UnderlineModifier(selectedIndex: selectedIndex, frames: frames))
            }
        }
        .frame(height: 40)
    }
}

struct SegmentedPickerView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerView(titles: ["Username", "Phone"], selectedIndex: .constant(0))
    }
}

private extension SegmentedPickerView {
    @ViewBuilder
    func _titlesBuilder(title: Any) -> some View {
        if(title is String) {
            _text(title: title as! String)
        } else {
            _image(image: title as! Image)
        }
    }
    
    func _text(title: String) -> some View {
        Text(title)
            .font(.sfProTextSemibold(20, relativeTo: .caption1))
            .frame(height: 40)
    }
    
    func _image(image: Image) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: 24, height: 24)
            .padding(.bottom, 10)
    }
}
