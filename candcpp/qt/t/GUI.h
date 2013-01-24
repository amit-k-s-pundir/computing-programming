#ifndef GUI_H
#define GUI_H

#include <QMainWindow>

class GUI : public QMainWindow{
        Q_OBJECT

        public:
        GUI();
        void setup_GUI();
};
#endif // GUI_H
