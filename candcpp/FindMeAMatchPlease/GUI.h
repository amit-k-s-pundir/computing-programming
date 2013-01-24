#ifndef GUI_H
#define GUI_H

#include <QtGui>

class App_panel: public QMainWindow{
        Q_OBJECT

        public:
        App_panel();
        void initialize_gui();

        protected:
        QWidget* set_control_panel(QWidget* control_panel);
        QWidget* set_view_panel(QWidget* view_panel);



        private slots:
//        void show_basic_info();

        private:
        QWidget* header, *footer, *left_margin, *right_margin;
        QWidget* control_panel; // Controls various aspects of the state
        // display and provides an implementation of the transition rules of the
        // state. This will be the left child of the main app panel initially.
        QWidget* view_panel; // Provides a view into the state. This will be the
        // right child of the main app panel initially.
};

#endif // GUI_H

