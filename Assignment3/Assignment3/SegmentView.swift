//
//  SegmentView.swift
//  Assignment3
//
//  Created by OM SHELKE on 10/8/21.
//

import SwiftUI


struct SegmentView: View {
    
    @State var selectedOption: String = ""
    @State private var switchActivity = false
    @State private var message = "This is a sample text. You can start editing."
    @State private var textStyle = UIFont.TextStyle.body
    @State private var showAlert = false

    let options = ["Progress", "Text", "Alert"]
    
    struct Spinner: UIViewRepresentable {
        let isAnimating: Bool
        let style: UIActivityIndicatorView.Style
        let color: UIColor

        func makeUIView(context: UIViewRepresentableContext<Spinner>) -> UIActivityIndicatorView {
            let spinner = UIActivityIndicatorView(style: style)
            spinner.hidesWhenStopped = false
            spinner.color = color
            return spinner
        }

        func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Spinner>) {
            isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
        }
    }
    
    struct TextView: UIViewRepresentable {
     
        @Binding var text: String
        @Binding var textStyle: UIFont.TextStyle
     
        func makeUIView(context: Context) -> UITextView {
            let textView = UITextView()
     
            textView.font = UIFont.preferredFont(forTextStyle: textStyle)
            textView.autocapitalizationType = .sentences
            textView.isSelectable = true
            textView.isUserInteractionEnabled = true
            textView.layer.borderWidth = 1
            textView.backgroundColor = .brown
            return textView
        }
     
        func updateUIView(_ uiView: UITextView, context: Context) {
            uiView.text = text
            uiView.font = UIFont.preferredFont(forTextStyle: textStyle)
        }
    }

    var body: some View {
        VStack{
            Picker("Select Country", selection: $selectedOption) {
                ForEach(options, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)
            .padding(30)
            
            if selectedOption == "Progress" {
                Toggle("Activity Indicator ", isOn: $switchActivity)
                    .padding(20)
                Spinner(isAnimating: switchActivity, style: .large, color: .blue)
                    .scaleEffect(2)
                    .padding(20)
            }
            
            else if selectedOption == "Text" {
                Text("Text selected")
                TextView(text: $message, textStyle: $textStyle)
                    .padding(.horizontal)
                    
            }
            
            else if selectedOption == "Alert" {
                Button("Tap to view alert") {
                            showAlert = true
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Feedback!"),
                                message: Text("Do you like iPhone?"),
                                primaryButton: Alert.Button.default(Text("Yes")),
                                secondaryButton: Alert.Button.cancel(Text("No"))
                            )
                        }
            }
            Spacer()
        }
        
    }
        
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView()
    }
}
