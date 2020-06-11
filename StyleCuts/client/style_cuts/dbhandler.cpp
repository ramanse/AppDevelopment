#include "dbhandler.h"
#include <QDebug>
DBHandler::DBHandler()
{
    m_networkManger = new QNetworkAccessManager(this);
}

void DBHandler::appointmentRequest(CustomerModel *customer)
{
    if (customer && m_networkManger) {
        qCritical()<<"Customer Details"<<customer->doa();


        QUrl url("http://192.168.0.165:5001/customers/add");
        QNetworkRequest request(url);

        request.setHeader(QNetworkRequest::ContentTypeHeader, "application/x-www-form-urlencoded");

        QByteArray postData;
        postData.append("name="+customer->name());
        postData.append("&contact="+customer->contact());
        postData.append("&doa="+customer->doa());


        //QObject::connect(m_networkManger, &QNetworkAccessManager::finished, this, SLOT(replyFinished(QNetworkReply *)));

        m_networkManger->post(request, postData);

    }
}

void DBHandler::replyFinished(QNetworkReply *reply)
{
    qCritical()<<"Reply posted "<<reply;
}
