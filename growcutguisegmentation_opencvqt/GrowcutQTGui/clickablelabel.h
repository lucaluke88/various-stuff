#ifndef CLICKABLELABEL_H
#define CLICKABLELABEL_H

#include "import_libraries.h"

using namespace cv;
using namespace std;

class ClickableLabel : public QLabel
{
        Q_OBJECT
    public:
        explicit ClickableLabel(QWidget* parent=0 );
        ~ClickableLabel();

    signals:
        void clicked();

    protected:
        void mouseMoveEvent(QMouseEvent* event);
        void mouseReleaseEvent(QMouseEvent* event);
        void mousePressEvent(QMouseEvent* event);

    private:
        Mat tmp_img;
        vector<Point> polilinea;
};

#endif // CLICKABLELABEL_H
