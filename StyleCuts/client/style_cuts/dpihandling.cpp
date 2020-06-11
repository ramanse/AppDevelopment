#include "dpihandling.h"
#include <QGuiApplication>
#include <QRect>
#include <QScreen>
#include <QDebug>

DPIHandling::DPIHandling()
{
    qreal refDpi = 216.;
    qreal refHeight = 1334.;
    qreal refWidth = 720.;
    QRect rect = QGuiApplication::primaryScreen()->geometry();
    qreal height = qMax(rect.width(), rect.height());
    qreal width = qMin(rect.width(), rect.height());
    qreal dpi = QGuiApplication::primaryScreen()->logicalDotsPerInch();
    m_scaleFactor = qMin(height/refHeight, width/refWidth);
    m_fontFactor = qMin(height*refDpi/(dpi*refHeight), width*refDpi/(dpi*refWidth));
    qCritical()<<"Screen rec"<< rect;
    qCritical()<<"m_scaleFactor rec"<< m_scaleFactor;
    qCritical()<<"m_fontFactor rec"<< m_fontFactor;


}
