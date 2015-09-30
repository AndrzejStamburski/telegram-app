import QtQuick 2.4
import Ubuntu.Components 1.3
import Ubuntu.Content 1.1

import "components"

Page {
    id: picker
    title: "Choose"

    Component {
        id: resultComponent
        ContentItem {}
    }

    visible: true
    property var url
    property var handler
    property var contentType
    property var curTransfer

    function __exportItems(url) {
        if (picker.curTransfer.state === ContentTransfer.InProgress)
        {
            picker.curTransfer.items = [ resultComponent.createObject(picker, {"url": url}) ];
            picker.curTransfer.state = ContentTransfer.Charged;
        }
    }

    ContentPeerPicker {
        visible: parent.visible
        contentType: picker.contentType
        handler: picker.handler
        showTitle: false
        onPeerSelected: {
            picker.curTransfer = peer.request();
            pageStack.pop();
            if (picker.curTransfer.state === ContentTransfer.InProgress)
            picker.__exportItems(picker.url);
        }
        onCancelPressed: {
            pageStack.pop();
        }
    }

    Connections {
        target: picker.curTransfer
        onStateChanged: {
            console.log("curTransfer StateChanged: " + picker.curTransfer.state);
            if (picker.curTransfer.state === ContentTransfer.InProgress) {
                picker.__exportItems(picker.url);
            }
        }
    }
}
