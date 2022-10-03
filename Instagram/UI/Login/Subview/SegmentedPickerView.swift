import SwiftUI

struct SegmentedPickerView: View {
    private let titles: [String]
    @Binding private var selectedIndex: Int
    @State private var frames: Array<CGRect>
    
    init(titles: [String], selectedIndex: Binding<Int>)
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
                            selectedIndex = index
                        })
                        {
                            Text(titles[index])
                                .font(.sfProTextSemibold(15, relativeTo: .title1))
                                .frame(height: 40)
                                .frame(width: geometry.size.width / CGFloat(titles.count))
                                .foregroundColor(.black)
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
