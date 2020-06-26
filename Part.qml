import QtQuick 2.0


Item {
    id: part
    width: 150
    height: 160
    visible: true; // указываем, что объект виден
    Flipable { // свойство, означающее поворот объекта
        id: main
        property bool flipped: false // перевернуто ли изображение
        width: 150
        height: 160

        front: Cell { // помещение нашего объекта в область видимости одной стороны
            id: f
            x: 5 // смещение по х от левой границы
            y: 5 // смещение по у от верхней границы
            rang: "a" // отображаемый текст
        }
        back: Cell { // то же самое, что и выше, только с обратной стороны
            id: b
            rang: "b" // на обратной стороне пишем b
        }

        transform: Rotation { // способ трансформации изображения
            id: rotation // поворот
            origin.x: 75; origin.y: 85
            axis {x: 0; y: 1; z:0} // как поворачиваем
            angle: 0 // угол
        }

        states: State { // задаем состояние
            name: "back" // название состояния
            PropertyChanges { target: rotation; angle: 180} // изменяемые параметры
            when: main.flipped // когда переменная указывает на то, что был совершен переворот
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 500;} // задаем время анимации
        }

        MouseArea { // указваем, что будем делать при клике на картинку
            anchors.fill: main
            onClicked: main.flipped = !main.flipped // меняем значение переменной

        }
    }
}
