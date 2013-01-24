#include "GUI.h"
#include <QtGui>


App_panel::App_panel(){

}


QWidget* App_panel::set_control_panel(QWidget* control_panel){
        QWidget* p;
        if(NULL == control_panel){
                        p = new QWidget;
          }else{
                        p = control_panel;
          }
        p = new QWidget;
        p->setBackgroundRole(QPalette::Dark);
        return p;
}

QWidget* App_panel::set_view_panel(QWidget* view_panel){
        QWidget* p;
        if(0 == view_panel){
                        p = new QWidget;
                }else{
                        p = view_panel;
                }
        p = new QWidget;
        p->setBackgroundRole(QPalette::Dark);
        return p;
}

void App_panel::initialize_gui(){
  control_panel = set_control_panel(control_panel); // The left_panel in the main window.
  view_panel = set_view_panel(view_panel);    // The right_panel in the main window.
 // read_settings();
  QHBoxLayout* layout = new QHBoxLayout;
//  layout->setSizeConstraint(QLayout::SetNoConstraint);
  //layout->setSizeConstraint(QLayout::SetFixedSize);
  layout->addWidget(control_panel);
  layout->addWidget(view_panel);
  setLayout(layout);
//  this->addItem(control_panel);
 // additem(view_panel);
}
