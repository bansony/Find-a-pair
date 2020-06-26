import QtQuick 2.12

Rectangle{
    id: kv
    width:70
    height: 70

    property int photos: part.photos

    border.width: 1
    border.color: "orange"
    visible: true

    Image {

        id: photo

        width: 70
        height: 70
        source: `img/${photos}.png`
        visible: true
        anchors.centerIn:kv
        }
}

