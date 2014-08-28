#ifndef BUTTON_H
#define BUTTON_H

class Button : public QToolButton{
  Q_OBJECT

  public:
  explicit Button(const string& text, QWidget* parent = 0);
  QSize sizeHint() const;
};

#endif
