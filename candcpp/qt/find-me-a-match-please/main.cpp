#include "mainwindow.h"
#include "GUI.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
   // MainWindow w;
    QGraphicsScene scene;
    scene.addItem(new AppPanel);
    QGraphicsView view(&scene);
    view.resize(700, 700);
    view.show();
    //app.initialize_gui();
    //w.show();
    
    return app.exec();
}
