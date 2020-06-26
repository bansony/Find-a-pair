import QtQuick 2.12
import QtQuick.Controls 2.12 //Реализация элементов управления (кнопок)
import QtQuick.Layouts 1.12 //Компановщик для расставления элементов

RowLayout{
    id:rl
    spacing: 2

    signal newGame()
    signal quitApp()
    signal gameOver()
    signal musicPlay()

    property int word: musicImage.word
    property int timeGame: 150


    Connections{
        target: helper
        onWinSignal:{
            musicImage.word=2
            musicImage.source="films/notsong.png"
            gameOverTime.cansel=true
        }
    }


    Button{
        id: newGameButton
        text: "New Game"
        onClicked:{
            newGame()
            gameOverTime.cansel=false
            timeGame=150
            musicImage.word=1
            musicImage.source="films/song.png"
        }
    }

    TextField{
        id: timerField

        Layout.fillWidth: true
        readOnly: true //только для чтения
        Timer { //установка таймера
            id: gameOverTime

            property bool cansel: false

            interval:1000
            running: true
            repeat: true
            onTriggered: {
                if ((timeGame>0) && (cansel == false)){ //если таймер не равен 0 и не выведено сообщение о выигрыше
                    timeGame=timeGame-1;
                }
                time.text = timeGame.toString();
                if (timeGame==0) {
                    gameOver()
                }
            }
        }
        Text {
            id: time
            anchors.centerIn: parent //расположить по центру поля
            font.pixelSize: 20 //установить размер шрифта в пикселях
        }
    }


    Button{
        id: musicButton
        Image {

            id: musicImage
            property int word:1
                source: "films/song.png"
                anchors.centerIn: parent
            }
        onClicked:{
            musicPlay()

            if (word==1){
                musicImage.source="films/notsong.png"
                musicImage.word=2
            } else {
                musicImage.source="films/song.png"
                musicImage.word=1
            }
        }
    }



    Button{
        id: quitButton
        text: "Quit"
        onClicked: quitApp()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequences: ["Ctrl+N"]
        onActivated: newGame()
    }

    Shortcut {
        context: Qt.ApplicationShortcut
        sequences: ["Ctrl+Q", StandardKey.Close]
        onActivated: quitApp()
    }
}
