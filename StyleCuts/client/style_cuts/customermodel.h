#ifndef CUSTOMERMODEL_H
#define CUSTOMERMODEL_H

#include <QObject>
class CustomerModel: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString contact READ contact WRITE setContact NOTIFY contactChanged)
    Q_PROPERTY(QString doa READ doa WRITE setDoa NOTIFY doaChanged)
    Q_PROPERTY(QString message READ message WRITE setMessage NOTIFY messageChanged)

public:
    CustomerModel() ;
    ~CustomerModel();

    const QString& name(){
        return  m_name;
    }
    void setName(const QString &fname){
        m_name = fname;
        emit nameChanged();
    }
    const QString& contact(){
        return  m_contact;
    }
    void setContact(const QString &fContact){
        m_contact = fContact;
        emit contactChanged();
    }
    const QString& doa(){
        return  m_doa;
    }
    void setDoa(const QString &fdoa){
        m_doa = fdoa;
        emit doaChanged();
    }
    const QString& message(){
        return  m_message;
    }
    void setMessage(const QString &fmessage){
        m_message = fmessage;
        emit messageChanged();
    }
signals:
    void nameChanged();
    void contactChanged();
    void doaChanged();
    void messageChanged();

private:
    QString m_name;
    QString m_contact;
    QString m_doa;
    QString m_message;
};

#endif // CUSTOMERMODEL_H
