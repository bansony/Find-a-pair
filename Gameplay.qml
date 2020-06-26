import QtQuick 2.12
import QtQuick.Layouts 1.12 //Компоновщик для расстанвления элементов
import QtQuick.Controls 2.12
import QtMultimedia 5.12


Rectangle{

   id: fon
    width: 600
    height: 550

    property int pictures
    property int sounds

    Image {
        id: group
        source: "films/Fon.png"
    }

    Image {
        width: 420
        height: 420
        id: back
        source: `films/${pictures}.png`
        anchors.centerIn: parent
    }

    Audio{
        id: playmusic
        source:`sound/${sounds}.wav`
    }

    Audio{
        id: playfon
        source:`sound/The Flow.wav`
    }

    Connections{
               target:helper
               onWinSignal:{
                   playfon.stop()
                   playmusic.play()
                   gameWin.visible=true
               }
           }


    Text {
        id: gameWin
        visible: false
        x:150
        y:2

        font.pixelSize: 40
        text: qsTr("Congratulations!!!")

        Timer{
            id: nene
            interval: 500
            running: true
            repeat: true

            onTriggered:{

                mainAnimation.start()
            }
        }

        SequentialAnimation{
            id: mainAnimation

        PropertyAnimation {id: animateColor; target: gameWin; properties: "color"; to: "yellow"; duration: 1000}
        PropertyAnimation {id: animateColor1; target: gameWin; properties: "color"; to: "red"; duration: 1000}
        }
    }

    function gameOverText(){
        gameOver.visible=true
        playfon.stop()
        gameOverMusic.play()
}

    function musicPlayer(){
        if (playfon.playbackState== Audio.StoppedState){
                      playfon.play()
        } else{
            playfon.stop()
        }
    }

    function newGame() {
        playmusic.stop()
        playfon.play()
        gameWin.visible=false
        gameOver.visible=false
        gameOverMusic.stop()

       var newGamePosition=helper.newGame()
        for (var i=0; i < newGamePosition.length; i++){
            bricks.itemAt(i).zoom=false
            bricks.itemAt(i).opacity=1
            bricks.itemAt(i).photos=newGamePosition[i]
        }

        pictures=helper.background()
        sounds=pictures
    }

    function changePosition() {
        var brickPhoto =[];
        var brickZoom = [];
        var brickVisible =[]
        for (var i=0;i<bricks.count;i++){
                brickPhoto.push(bricks.itemAt(i).photos)
                brickZoom.push(bricks.itemAt(i).zoom)
                brickVisible.push(bricks.itemAt(i).opacity)
            }

        var gamePosition=helper.change(brickPhoto,brickZoom)
            for (var j=0;j<gamePosition.length;j++){
                bricks.itemAt(j).zoom=gamePosition[j]
               }


        var disappear=helper.finally(brickVisible,brickZoom,brickPhoto)
            for (var h=0;h<disappear.length;h++){
                bricks.itemAt(h).opacity=disappear[h]
                if (bricks.itemAt(h).opacity===0){
                    bricks.itemAt(h).zoom=false
                }
            }
    }

    GridLayout{
        id: gl
        anchors.centerIn: parent
        columnSpacing: 0.2
        rowSpacing: 0.2
        columns: 6
        rows: 6

        Repeater{
            id: bricks
            model: 36
            Brick{
                onRotated: changePosition()

            }
        }
    }

    Component.onCompleted: {
    newGame()
    }
    Item {
        id: gameOver
        visible: false
        width: fon.width
        height: fon.width
        anchors.centerIn: parent

        Audio{
            id: gameOverMusic
            source:"sound/gameOverMusic.wav"
        }

        Image {
        id: fonOver
        width: gameOver.width
        height: gameOver.height
        source: "films/FonOver.png"
        anchors.centerIn: parent
    }

        Text {
            id: over
            x:150
            y:2
            anchors.centerIn: parent

            font.pixelSize: 60
            text: qsTr("You lose\n Try again!!!")

            Timer{
                id: xexe
                interval: 500
                running: true
                repeat: true

                onTriggered:{

                    mainAnimation1.start()
                }
            }

            SequentialAnimation{
                id: mainAnimation1

            PropertyAnimation {id: animateColor3; target: over; properties: "color"; to: "yellow"; duration: 1000}
            PropertyAnimation {id: animateColor4; target: over; properties: "color"; to: "red"; duration: 1000}
            }
          }
    }

}
