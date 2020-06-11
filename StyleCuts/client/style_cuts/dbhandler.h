#ifndef DBHANDLER_H
#define DBHANDLER_H

#include<QObject>
#include<QSqlDatabase>
#include<QQuickItem>
#include"customermodel.h"
#include <QNetworkAccessManager>
#include <QUrl>
#include <QUrlQuery>
#include <QNetworkReply>

class DBHandler: public QQuickItem
{
    Q_OBJECT
public:
    DBHandler();
    Q_INVOKABLE void appointmentRequest(CustomerModel*);

private:
    QSqlDatabase m_scrollDB;
    QNetworkAccessManager *m_networkManger;

 private slots:
    void replyFinished(QNetworkReply *reply);

};

#endif // DBHANDLER_H
