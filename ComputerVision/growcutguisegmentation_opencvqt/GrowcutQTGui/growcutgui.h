#ifndef GROWCUTGUI_H
#define GROWCUTGUI_H

#include "import_libraries.h"


using namespace cv; // opencv namespace
using namespace std; // standard namespace
using namespace QtOcv; // conversione Mat2QImg e viceversa

namespace Ui {
    class GrowcutGUI;
}

class GrowcutGUI : public QMainWindow
{
        Q_OBJECT

    public:

        explicit GrowcutGUI(QWidget *parent = 0);
        ~GrowcutGUI();

        Ui::GrowcutGUI *ui;

        // fattori di scaling per convertire
        static int getScaleFactorRows();
        static int getScaleFactorCols();
		static bool getCropMode();
        Mat labelset; // contiene -1,0,+1 come etichette dei pixel
        void aggiornaPreview(ClickableLabel *where, Mat opencvimage);
        Mat mat_anteprima_originale;

    private slots:

        void on_actionApri_immagine_triggered();
        void on_confermaDatibutton_clicked();
        void on_patologiaLista_clicked(const QModelIndex &index);
        void on_actionSegmenta_ora_triggered();
        void keyPressEvent(QKeyEvent * keyevent);
        void keyReleaseEvent(QKeyEvent * keyevent);
        void on_actionSalva_lavoro_rapidamente_triggered();

        void on_actionRitaglia_immagine_triggered();

    private:
        QString fileName;

        // altri metodi inutili, accedo direttamente all'oggetto che voglio impostare
        void setAnteprimaOriginale(const Mat opencvimg);
        void setAnteprimaSana(const Mat opencvimg);
        void setAnteprimaMalata(const Mat opencvimg);
        Mat mat_anteprima_sana, mat_anteprima_malata;


};

#endif // GROWCUTGUI_H
