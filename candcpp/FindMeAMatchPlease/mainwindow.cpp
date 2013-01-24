#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
  QMainWindow(parent),
  ui(new Ui::MainWindow)
{
        createActions();
        createMenu();
        createToolBar();
        createStatusBar();
  ui->setupUi(this);
}

MainWindow::~MainWindow()
{
  delete ui;
}

void createGUI(){
        GridLayout* layout;
}
