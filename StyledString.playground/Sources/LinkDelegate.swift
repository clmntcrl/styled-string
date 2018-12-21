import UIKit

public class LinkDelegate: NSObject {

    let onInteractWithLink: (URL) -> Void

    public init(onInteractWithLink: @escaping (URL) -> Void) {
        self.onInteractWithLink = onInteractWithLink
    }
}

extension LinkDelegate: UITextViewDelegate {

    public func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        onInteractWithLink(URL)
        return false
    }
}
