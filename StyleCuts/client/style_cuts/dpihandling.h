#ifndef DPIHANDLING_H
#define DPIHANDLING_H

#include <QObject>

class DPIHandling: public QObject
{
    Q_OBJECT
    Q_PROPERTY(qreal scaleFactor READ scaleFactor)
    Q_PROPERTY(qreal fontFactor READ fontFactor)
public:
    DPIHandling();

    qreal scaleFactor() const
       { return m_scaleFactor; }

    qreal fontFactor() const
       { return m_fontFactor; }
signals:
    void scaleFactorChanged();
    void fontFactorChanged();
private:
    qreal m_scaleFactor = 1.0;
    qreal m_fontFactor = 1.0;
};

#endif // DPIHANDLING_H
