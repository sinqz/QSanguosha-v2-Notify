import QtQuick 2.15
import "../Util/skin-bank.js" as SkinBank

CardItem {
    property int gid: 0
    property string kingdom: "qun"
    description: Sanguosha.getGeneralDescription(name)
    suit: ""
    number: 0
    card.source: SkinBank.GENERAL_CARD_DIR + name + ".jpg"
    glow.color: "white" //Engine.kingdomColor[kingdom]
}
