#include <QtGui>
#include "GUI.h"


AppPanel::AppPanel(QGraphicsWidget *parent)
        : QGraphicsWidget(parent){
        QGraphicsLayout* appLayout = new QGraphicsGridLayout;
        setLayout(appLayout);
        viewPanel = new QGraphicsWidget;
        controlPanel = new QWidget;
//        QPainter* painter;
        appLayout->addWidget(viewPanel, 0, 0);
        appLayout->addWidget(controlPanel, 0, 1);
 //       painter->setBrush(Qt::green);
        //layout->addWidget(header);
//        QHBoxLayout* displayLayout = new QHBoxLayout;
//        displayPanel = new QGraphicsWidget;
//        viewPanel = new QLabel("View Panel");
//        panelLayout->addWidget(viewPanel);
//        controlPanel = new QLabel("Control Panel");
//        panelLayout->addWidget(controlPanel);
//        panel->setLayout(panelLayout);
//        layout->addWidget(panel);
//      //  footer = new QLabel("footer");
//        layout->addWidget(footer);
//        setLayout(layout);
//        layout->addWidget();
        setWindowTitle(tr("find-me-a-match-please"));
        show();
}

void create_view(){
        QGridLayout* layout = new QGridLayout;

}
void AppPanel::initialize_gui(){
}

