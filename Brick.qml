import QtQuick 2.12


Item {
    id: part
    width: 70
    height: 70
    opacity: 1
    visible: true; // указываем, что объект виден


      property int timeAnimation: 2
      property int photos
      property bool zoom

      signal rotated()

       Flipable { // свойство, означающее поворот объекта

        id: flip
        width: 70
        height: 70

        property bool flipped: zoom // перевернуто ли изображение


        front: Front { // помещение нашего объекта в область видимости одной стороны

        }

        back: Back { // то же самое, что и выше, только с обратной стороны

        }

        transform: Rotation { // способ трансформации изображения
            id: rotation // поворот
            origin.x: 35; origin.y: 35
            axis {x: 0; y: 1; z:0} // как поворачиваем
            angle: 0 // угол
        }

        states: State { // задаем состояние
            name: "back" // название состояния
            PropertyChanges { target: rotation; angle: 180} // изменяемые параметры
            when: flip.flipped // когда переменная указывает на то, что был совершен переворот
        }

        transitions: Transition {

            NumberAnimation {target: rotation; property: "angle"; duration: 500;} // задаем время анимации

        }


        MouseArea { // указваем, что будем делать при клике на картинку
            anchors.fill: flip
            onClicked:{
                zoom = rotation // меняем значение переменной
                timerEnd.start()
                 }
            }
        }

    Timer{
        id: timerEnd
        interval: 500
        running: true
        repeat: false

        onTriggered:  {
            if (timeAnimation>0){
                timeAnimation=timeAnimation-1;
            }
            if (timeAnimation==0){
                rotated()
            }
        }
    }

}


