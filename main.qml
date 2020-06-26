import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.12 //Компоновщик для расстанвления элементов
import QtQuick.Controls 2.12
import QtMultimedia 5.12

Window{
    id: w

    visible: true
    minimumWidth: 600
    maximumWidth: 600
    width: 600

    minimumHeight: cl.height
    maximumHeight: cl.height
    height: cl.height
    title: qsTr("Find a pair")


        ColumnLayout{

        id:cl

        anchors.centerIn: w.contentItem
        spacing: 2

        Gameplay{

            id: gameplay
        }


        Toolbar{
            id: toolbar

            onNewGame:  gameplay.newGame()

            onQuitApp: Qt.quit()

            onMusicPlay: gameplay.musicPlayer()

            onGameOver: gameplay.gameOverText()

        }
    }
}

