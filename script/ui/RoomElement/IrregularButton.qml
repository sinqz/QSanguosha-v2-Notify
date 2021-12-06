import QtQuick 2.15
import "../Util/skin-bank.js" as SkinBank

Item {
    property string name
    property string mouseState: "normal"

    signal clicked
    signal doubleClicked

    id: button

    Image {
        source: SkinBank.BUTTONS_DIR + name + "/" + (enabled ? mouseState : "disabled")

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onClicked: button.clicked();
            onDoubleClicked: button.doubleClicked();
            onEntered: mouseState = "hover";
            onExited: mouseState = "normal";
            onPressed: mouseState = "down";
            onReleased: mouseState = containsMouse ? "hover" : "normal";
        }
    }
}
