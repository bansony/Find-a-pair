#include "helper.h"
#include <QDebug>

Helper::Helper(QObject *parent) : QObject(parent)
{

}

QVector<int> Helper::newGame()
{
    QVector<int> bricks;
    QVector<int> numbers;
    int k=1;

    srand(time(0));

    for (int i = 0; i < 36; i++) {
        bricks.push_back(0);
    }
    for (int i = 0; i < 18; i++) {
        numbers.push_back(0);
    }
    for (int i=0; i<18; i++){
        numbers[i]=(rand()%72+1);
        }

    while (true){
        if (!k) {
            break;
        }
   k=0;
        for (int i=0; i<17; i++)
        {
            for (int j=i+1; j<18; j++)
            {
                if (numbers[i]==numbers[j]) {
                    numbers[i]=(rand()%72+1);
                    k++;
                }
            }
        }
    }

    for (int i = 0; i < 18; i++) {
        bricks[i]=numbers[i];
        bricks[i+18]=numbers[i];
    }

    for (int i=35; i>=1; i--){
        int j = rand()%(i+1);
        int tmp = bricks[j];
        bricks[j] = bricks[i];
        bricks[i] = tmp;
    }

    return bricks;
}

QVector<bool> Helper::change(QVector<int>photos,QVector<bool>position)
{
    int k=0;
    int z=0,h=100;
    QVector<bool>change;

    for (int i = 0; i < 36; i++) {
        change.push_back(false);
    }

    for (int i=0; i<36; i++){
        change[i]=position[i];
    }

    for (int i=0; i<36; i++){
        if (position[i]==true){
            k++;
        }
    }

    if (k==2){
        for (int j=0; j<36; j++){
            if (position[j]==true){
                z=j;
                if (h==100){
                    h=j;
                }
            }
        }

        if (photos[z]!=photos[h]){
            change[z]=false;
            change[h]=false;
        }
   }

    if (k>2){
       for (int i=0; i<36; i++){
           if (position[i]==true){
               change[i]=false;
           }
       }
    }

    return change;
}

QVector<int> Helper::finally(QVector<int>vid,QVector<bool>position,QVector<int>photos)
{
    int k=0,count=0;
    int z=0,h=100;
    QVector<int>finally;

    for (int i = 0; i < 36; i++) {
        finally.push_back(vid[i]);
    }

    for (int i=0; i<36; i++){
        if (position[i]==true){
            k++;
        }
    }

    if (k==2){
        for (int j=0; j<36; j++){
            if (position[j]==true){
                z=j;
                if (h==100){
                    h=j;
                }
            }
        }

        if (photos[z]==photos[h]){
            finally[z]=0;
            finally[h]=0;
        }
   }

    for (int i=0; i<36; i++){
        if (finally[i]==0){
            count++;
        }
    }

    if (count==36){
        emit winSignal();
    }

    return finally;
}

int Helper::background()
{
    srand(time(0));
    int background=0;

    background=(rand()%17+1);
    return background;
}

