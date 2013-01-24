#include <QApplication>
#include "GUI.h"
#include <vector>
#include <string>


int main(int argc, char* argv[])
{
  QApplication app(argc, argv);

  App_panel app_panel;
  app_panel.initialize_gui();
  app_panel.show();
  
  return app.exec();
}
