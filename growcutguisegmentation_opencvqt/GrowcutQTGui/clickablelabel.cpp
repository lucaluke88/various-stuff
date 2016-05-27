#include "clickablelabel.h"
#include <growcutgui.h>
#include <cvmatandqimage.h>

/**
 * @brief ClickableLabel::ClickableLabel
 * @param parent
 */

ClickableLabel::ClickableLabel(QWidget* parent)
	: QLabel(parent)
{

}

/**
 * @brief ClickableLabel::~ClickableLabel
 */
ClickableLabel::~ClickableLabel()
{
}

/**
 * @brief ClickableLabel::mousePressEvent
 * @param event
 */
void ClickableLabel::mouseMoveEvent(QMouseEvent* event)
{
	if(GrowcutGUI::getCropMode())
	{
		// mouse clicked
		emit clicked();
	}
	else
	{


		// mouse clicked
		emit clicked();

		// COORDINATE REALI
		int pos_x = (int) event->x() * GrowcutGUI::getScaleFactorCols();
		int pos_y = (int) event->y() * GrowcutGUI::getScaleFactorRows();

		polilinea.push_back(Point(pos_x,pos_y));
	}

}

void ClickableLabel::mouseReleaseEvent(QMouseEvent* event)
{
	if(GrowcutGUI::getCropMode())
	{
		// mouse clicked
		emit clicked();
	}
	else
	{

		int pos_x = (int) event->x() * GrowcutGUI::getScaleFactorCols();
		int pos_y = (int) event->y() * GrowcutGUI::getScaleFactorRows();
		const cv::Point *pts = (const cv::Point*) Mat(polilinea).data;
		int npts = Mat(polilinea).rows;

		// quale anteprima dobbiamo modificare
		QImage picture = this->pixmap()->toImage();
		tmp_img = image2Mat(picture, CV_8UC3, MCO_RGB);
		GrowcutGUI * win = (GrowcutGUI *) QApplication::activeWindow();
		Point_<uchar>* label_value = win->labelset.ptr<Point_<uchar> >(pos_y,pos_x);

		if(event->button()==Qt::RightButton) // tasto destro mouse: malati (label 0)
		{
			polylines(tmp_img, &pts,&npts, 1, false, Scalar(255,0,0), 12, CV_AA, 0);
			label_value->x = 0;
		}

		else if(event->button()==Qt::MiddleButton) // tasto centrale mouse: reset (label 1)
		{
			polylines(tmp_img, &pts,&npts, 1, false, Scalar(0,0,255), 12, CV_AA, 0);
			label_value->x = 1;
		}

		else // tasto sinistro: sani (label 2)
		{
			polylines(tmp_img, &pts,&npts, 1, false, Scalar(0,255,0), 12, CV_AA, 0);
			label_value->x = 2;
		}

		QImage q_tmp_img = mat2Image_shared(tmp_img);
		QPixmap p_image = QPixmap::fromImage(q_tmp_img);
		this->setPixmap(p_image);
		this->show();
		polilinea.clear();
		cout << "release event" << endl;
	}


}

void ClickableLabel::mousePressEvent(QMouseEvent *event)
{
    if(GrowcutGUI::getCropMode())
    {
        // mouse clicked
        emit clicked();
        cout << " crop true" << endl;
    }
    else
    {
        cout << "crop false" << endl;
        // mouse clicked
        emit clicked();
        // COORDINATE PREVIEW
        int pos_x = event->x();
        int pos_y = event->y();

        // COORDINATE REALI
        pos_x = (int) pos_x * GrowcutGUI::getScaleFactorCols();
        pos_y = (int) pos_y * GrowcutGUI::getScaleFactorRows();

        QImage picture = this->pixmap()->toImage();
        tmp_img = image2Mat(picture, CV_8UC3, MCO_RGB);

        GrowcutGUI * win = (GrowcutGUI *) QApplication::activeWindow();
        Point_<uchar>* label_value = win->labelset.ptr<Point_<uchar> >(pos_y,pos_x);

        if(event->button()==Qt::RightButton) // tasto destro mouse: malati (label 0)
        {
            circle( tmp_img, Point(pos_x, pos_y), 25, Scalar( 255, 0, 0 ), -1, 8 );
            // setta quelle coordinate a -1 o cmq label malata
            label_value->x = 0;
        }

        else if(event->button()==Qt::MiddleButton) // tasto centrale mouse: reset (label 1)
        {
            circle( tmp_img, Point(pos_x, pos_y), 25, Scalar( 0, 0, 255 ), -1, 8 );
            // setta quelle coordinate a -1 o cmq label malata
            label_value->x = 1;
        }

        else // tasto sinistro: sani (label 2)
        {
            circle( tmp_img, Point(pos_x, pos_y), 25, Scalar( 0, 255, 0 ), -1, 8 );
            label_value->x = 2;
        }

        QImage q_tmp_img = mat2Image_shared(tmp_img);
        QPixmap p_image = QPixmap::fromImage(q_tmp_img);
        this->setPixmap(p_image);
        this->show();
    }
}
