import QtQuick 2.15
import "../Util/skin-bank.js" as SkinBank

Item {
    property string avatar: ""
    property string kingdom: ""
    property string generalPosition: "head"
    property alias generalName: nameItem.text

    width: 128
    height: 153

    Image {
        source: SkinBank.FULLSKIN_DIR + avatar
        anchors.fill: parent
    }

    Image {
        source: SkinBank.DASHBOARD_AVATAR
        anchors.fill: parent
    }

    Image {
        x: 2
        y: 2
        source: SkinBank.KINGDOM_ICON_DIR + (kingdom != "" && kingdom != "hidden" ? kingdom : "god")
        visible: kingdom != ""

        Item {
            x: nameItem.text.length >= 3 ? 26: 28

            GlowText {
                id: nameItem
                font.family: "LiSu"
                font.pixelSize: 18
                color: "white"
                font.letterSpacing: text.length < 3 ? 9 : 0

                glow.spread: 0.7
                glow.radius: 3
                glow.samples: 6
                glow.color: "#222222"
            }

            transform: Scale {
                xScale: Math.min(1.0, 57 / nameItem.width)
            }
        }
    }

    Image {
        source: SkinBank.GENERAL_POSITION_DIR + generalPosition
    }
}
