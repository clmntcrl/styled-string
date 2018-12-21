import UIKit
import PlaygroundSupport

import StyledString

// Styles

var styles = (
    title: StyledString.createStyle([
        .font: UIFont.systemFont(ofSize: 32, weight: .heavy),
        .foregroundColor: UIColor.radicalRed
    ]),
    body: StyledString.createStyle([
        .font: UIFont.systemFont(ofSize: 14),
        .foregroundColor: UIColor.darkGray
    ]),
    bodyWithCustomColor: { (color: UIColor) -> (NSMutableAttributedString) -> Void in
        return StyledString.createStyle([
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: color
        ])
    },
    bodyLink: StyledString.createStyle([
        .font: UIFont.systemFont(ofSize: 14, weight: .bold),
    ]),
    marker: StyledString.createStyle([
        .font: UIFont.preferredFont(forTextStyle: .body),
        .foregroundColor: UIColor.softRed
    ])
)

// Get unicorn image

guard
    let imageURL = URL(string: "https://raw.githubusercontent.com/clmntcrl/styled-string/master/unicorn.png"),
    let imageData = try? Data(contentsOf: imageURL),
    let image = UIImage(data: imageData)
else { fatalError("Cannot get image") }

// Init the text view that will render the attributed string

let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 400, height: 380))
let linkDelegate = LinkDelegate(onInteractWithLink: { print($0) })
textView.delegate = linkDelegate
textView.backgroundColor = .capeHoney
textView.isEditable = false
textView.linkTextAttributes = [
    .foregroundColor: UIColor.cabaret,
]

// Build styled string and render it

textView.attributedText = StyledString([
    .text("StyledString ", style: styles.title),
    .image(image, baselineOffset: -24),
    .text("\nSimplify attributed string construction in Swift.\n", style: styles.body),
    .list(
        [
            .text("Declarative", style: styles.body),
            .text("Extensible", style: styles.body),
            .styledString([
                .text("S", style: styles.bodyWithCustomColor(.pomegranate)),
                .text("t", style: styles.bodyWithCustomColor(.radicalRed)),
                .text("y", style: styles.bodyWithCustomColor(.valencia)),
                .text("l", style: styles.bodyWithCustomColor(.softRed)),
                .text("i", style: styles.bodyWithCustomColor(.zest)),
                .text("s", style: styles.bodyWithCustomColor(.seaBuckthorn)),
                .text("h", style: styles.bodyWithCustomColor(.saffronMango)),
            ]),
        ],
        contentIndent: 26,
        marker: { _ in "•" },
        markerIndent: 8,
        markerStyle: styles.marker,
        itemSpacing: 3
    ),
    .text("\n\n⏤\n\nAuthor: ", style: styles.body),
    .link("@clmntcrl", url: "https://twitter.com/clmntcrl", style: styles.bodyLink),
]).render()

PlaygroundPage.current.liveView = textView

print("✅")
