//  Created by Cyril Clément
//  Copyright © 2018 clmntcrl. All rights reserved.

import UIKit

public struct StyledString {

    public let render: () -> NSAttributedString
}

// MARK: - Style creation

public extension StyledString {

    static func createStyle(_ attributes: [NSAttributedString.Key : Any]) -> (NSMutableAttributedString) -> Void {
        return { attrString in
            attrString.addAttributes(attributes, range: NSRange(location: 0, length: attrString.length))
        }
    }
}

// MARK: - Components

public extension StyledString {

    init(_ content: [StyledString], style: @escaping (NSMutableAttributedString) -> Void = { _ in }) {
        render = {
            let styledString = content
                .reduce(NSMutableAttributedString()) { styledString, component in
                    styledString.append(component.render())
                    return styledString
            }
            style(styledString)
            return styledString
        }
    }

    static func styledString(
        _ content: [StyledString],
        style: @escaping (NSMutableAttributedString) -> Void = { _ in }
    ) -> StyledString {

        return .init(content, style: style)
    }

    static func text(
        _ txt: String,
        style: @escaping (NSMutableAttributedString) -> Void = { _ in }
    ) -> StyledString {

        return .init {
            let styledText = NSMutableAttributedString(string: txt)
            style(styledText)
            return styledText
        }
    }

    static func link(
        _ txt: String,
        url: String,
        style: @escaping (NSMutableAttributedString) -> Void = { _ in }
    ) -> StyledString {

        return .text(txt, style: compose(style, StyledString.createStyle([ .link: url ])))
    }

    static func image(_ img: UIImage, baselineOffset offset: CGFloat = 0) -> StyledString {
        return .init {
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = img
            let imageAttrString = NSMutableAttributedString(attachment: imageAttachment)
            imageAttrString.addAttribute(
                .baselineOffset,
                value: offset,
                range: NSRange(location: 0, length: imageAttrString.length)
            )
            return imageAttrString
        }
    }

    static func list(
        _ content: [StyledString],
        contentIndent: CGFloat,
        marker: @escaping (Int) -> String = { _ in "-" },
        markerIndent: CGFloat,
        markerStyle: @escaping (NSMutableAttributedString) -> Void = { _ in },
        itemSpacing: CGFloat
    ) -> StyledString {

        return .init {
            let listItemParagraphStyle = NSMutableParagraphStyle()
            listItemParagraphStyle.firstLineHeadIndent = markerIndent
            listItemParagraphStyle.headIndent = contentIndent
            listItemParagraphStyle.paragraphSpacing = itemSpacing
            listItemParagraphStyle.tabStops = [
                NSTextTab(textAlignment: .natural, location: contentIndent, options: [:])
            ]
            let list = content
                .enumerated()
                .reduce(NSMutableAttributedString()) { list, listItemContent in
                    let listItem = StyledString.styledString(
                        [
                            .text("\n\(marker(listItemContent.offset))\t", style: markerStyle),
                            listItemContent.element
                        ],
                        style: StyledString.createStyle([ .paragraphStyle: listItemParagraphStyle ])
                    ).render()
                    list.append(listItem)
                    return list
            }
            list.append(.init(string: "\n"))
            return list
        }
    }
}

// MARK: -
