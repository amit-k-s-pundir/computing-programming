#include <QtWidget>
#include "buton.h"

Button::Button(const QString& text, QWidget* parent):QToolButton(parent){
  setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Preferred);
  setText(text);
}

QSize Button::sizeHint() const {
  QSize size = QToolButton::sizeHint();
  size.rheight() += 20;
  size.rwidth() = qmax(size.width(), size.height());
  return size;
}
