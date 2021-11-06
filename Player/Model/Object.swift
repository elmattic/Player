
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
           cid: "Qmce1T9s6z2u1DPFDnMgtmHuRd6yiB6fHNY9SSv8t2Qn5k"),
    Object(path: "03-NOOG.mp3", title: "Noog", author: "Jankenpopp",
           cid: "Qmce1T9s6z2u1DPFDnMgtmHuRd6yiB6fHNY9SSv8t2Qn5k"),
    Object(path: "01-KONAMI CREDIT CODE.mp3", title: "Konami Credit Code", author: "Jankenpopp",
           cid: "Qmce1T9s6z2u1DPFDnMgtmHuRd6yiB6fHNY9SSv8t2Qn5k"),
    Object(path: "02-GOOGLE BRAIN DEAD.mp3", title: "Google Brain Dead", author: "Jankenpopp",
           cid: "Qmce1T9s6z2u1DPFDnMgtmHuRd6yiB6fHNY9SSv8t2Qn5k"),
]

// The CIDs above represent mp3 tracks from Zombie Media stored on IPFS
// learn more about the album here: https://www.darlingdada.com/fr/album/zombie-media
//
// Zombie Media is licenced under CREATIVE COMMONS BY-NC-SA LICENCE 2013
//
