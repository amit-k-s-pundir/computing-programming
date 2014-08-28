#ifndef CALCULATOR_H
#define CALCULATOR_H

#include <QWidget>

class QLineEdit;

class Button;

class Calculator : public QWidget
{
  Q_OBJECT
  
public:
  Calculator(QWidget* parent = 0);

  private slots:
  void digitClicked();
  void unaryOperatorClicked();
  void additiveOperatorClicked();
  void multiplicativeOperatorClicked();
  void equalClicked();
  void pointClicked();
  void changeSignClicked();
  void backSpaceClicked();
  void clear();
  void clearAll();
  void clearMemory();
  void readMemory();
  void setMemory();
  void addToMemory();

private:
  Button* createButton(const QString& text, const char* member);
  void abortOperation();
  bool calculate(double rightOperand, const QString& pendingOperator);
  double sumInMemory;
  double sumSoFar;
  double factorSoFar;
  QString pendingMultiplicativeOperator;
  bool  waitingForOperand;
  QLineEdit* display;
  enum {numOfDigitButtons = 10};
  Button* digitButtons[numOfDigitButtons];
};

#endif

