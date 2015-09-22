import QtQuick 2.3
import Ubuntu.Components 1.1
import Ubuntu.Components.Popups 1.0

Dialog {
    id: dialogue
    title: i18n.tr("Telegram")
    // text is the property to fill for the dialog body

    property string acceptText: i18n.tr("OK")
    property string altText: "" 
    property string cancelText: i18n.tr("Cancel")
    property var onAccept: function() {}
    property var onAlt: function() {}
    property var onCancel: function() {
        PopupUtils.close(dialogue);
    }

    Button {
        text: acceptText
        color: UbuntuColors.green
        onClicked: optionSelected(onAccept)
    }

    Button {
        text: altText
        strokeColor: UbuntuColors.lightGrey
        visible: text.length > 0
        onClicked: optionSelected(onAlt)
    }

    Button {
        text: cancelText
        color: UbuntuColors.lightGrey
        onClicked: optionSelected(onCancel)
    }

    function optionSelected(option) {
        option();
        PopupUtils.close(dialogue);
    }
}
