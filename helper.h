#ifndef HELPER_H
#define HELPER_H

#include <QObject>
#include <QVector>

class Helper : public QObject
{
    Q_OBJECT
public:
    explicit Helper(QObject *parent = nullptr);

signals:
    void winSignal();

public slots:
    QVector<int> newGame();
    QVector<bool> change(QVector<int>photos,QVector<bool>position);
    QVector<int> finally(QVector<int>vid,QVector<bool>position,QVector<int>photos);
    int background();

};

#endif // HELPER_H
