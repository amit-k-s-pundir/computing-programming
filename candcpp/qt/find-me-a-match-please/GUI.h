#ifndef GUI_H
#define GUI_H

#include <QtGui>
#include <QtWidgets>
#include <QGraphicsWidget>

class AppPanel : public QGraphicsWidget{
       Q_OBJECT

public:
        AppPanel(QGraphicsWidget* parent = 0);
        void initialize_gui();
        public slots:

        protected:
        private:
        QWidget* controlPanel;
        QGraphicsWidget* viewPanel;
};
#endif // GUI_H

