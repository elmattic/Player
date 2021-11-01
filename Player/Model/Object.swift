
import SwiftUI

struct Object: Identifiable {
    var id: String = UUID().uuidString
    var path: String
    var title: String
    var author: String
    var cid: String
}

var allObjects = [
    Object(path: "04-EPIC CAT LOVER FRUM DA INTERWEB.mp3", title: "Epic Cat Lover Frum Da Interweb", author: "Jankenpopp",
           cid: "QmRx5d12GSKx12kMoETREQ7sJZu3ALaQmrctQQU6cQ6Tmo"),
    Object(path: "03-NOOG.mp3", title: "Noog", author: "Jankenpopp",
           cid: "QmRx5d12GSKx12kMoETREQ7sJZu3ALaQmrctQQU6cQ6Tmo"),
    Object(path: "01-KONAMI CREDIT CODE.mp3", title: "Konami Credit Code", author: "Jankenpopp",
           cid: "QmRx5d12GSKx12kMoETREQ7sJZu3ALaQmrctQQU6cQ6Tmo"),
    Object(path: "02-GOOGLE BRAIN DEAD.mp3", title: "Google Brain Dead", author: "Jankenpopp",
           cid: "QmRx5d12GSKx12kMoETREQ7sJZu3ALaQmrctQQU6cQ6Tmo"),
]
