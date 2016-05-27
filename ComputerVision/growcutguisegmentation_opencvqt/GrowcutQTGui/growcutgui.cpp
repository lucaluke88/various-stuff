/**
 * GrowcutGUI - Gui per la segmentazione di immagini dermatologiche
 * Sviluppato da Illuminato Luca Costantino - lucaluke.altervista.org
 */

#include "growcutgui.h"
#include "ui_growcutgui.h"


int scaleFactorRows, scaleFactorCols ;
bool cropMode = false;



//Mat mat_anteprima_originale, mat_anteprima_sana, mat_anteprima_malata;

GrowcutGUI::GrowcutGUI(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::GrowcutGUI)
{
    ui->setupUi(this);
}

GrowcutGUI::~GrowcutGUI()
{
    delete ui;
}

void GrowcutGUI::on_actionApri_immagine_triggered()
{
    // apertura file


    fileName = QFileDialog::getOpenFileName(this,"Apri immagine",QDir::currentPath());
    if(!fileName.isEmpty())
    {
        QImage q_anteprima_originale(fileName);
        if(q_anteprima_originale.isNull())
        {
            QMessageBox::information(this,"Importazione immagine","Errore nell'apertura dell'immagine");
            return;
        }
        else
        {
            // nome immagine
            ui->immagine_info_label->setText(fileName.section('/',-1));
            ui->istruzioni_label->setText("Tasto sinistro del mouse per la pelle sana, destro per la pelle malata, centrale per annullare la marcatura");
            // autoresize del contenuto nella label view
            ui->anteprima_originale->setScaledContents(true);
            ui->anteprima_sana->setScaledContents(true);
            ui->anteprima_malata->setScaledContents(true);

            // convertiamo in open cv mat
            Mat tmp = image2Mat(q_anteprima_originale, CV_8UC3, MCO_RGB);
            setAnteprimaOriginale(tmp);
            setAnteprimaSana(tmp*0);
            setAnteprimaMalata(tmp*0);

            // inizializziamo il labelset
            labelset=Mat::ones(Size(tmp.rows, tmp.cols), CV_8UC1);
            scaleFactorCols = mat_anteprima_originale.cols / ui->anteprima_originale->width();
            scaleFactorRows = mat_anteprima_originale.rows / ui->anteprima_originale->height();

        }

    }
}

void GrowcutGUI::on_confermaDatibutton_clicked()
{

    // salvataggio dati del paziente

    QString nomecognome = ui->nomecognome_edit->text();
    QString data = ui->dateEdit->date().toString();
    QString current_selected_row = ui->patologiaLista->currentItem()->text();

    QDir* qdir_istance = new QDir(); // altrimenti non possiamo accedere ai metodi
    QDir homeDir = qdir_istance->home(); // cartella home
    QString homePath = homeDir.absolutePath(); // ricaviamoci il path della home
    homeDir.mkdir(nomecognome+"_dati_"+data); // creiamo una cartella nella home di sistema
    QString filename = homePath +"/"+nomecognome+"_dati_"+data+"/dati_anagrafici.txt";
    filename = filename.replace(" ","_"); // togliamo gli spazi bianchi
    QFile file(filename);
    if (file.open(QIODevice::ReadWrite))
    {
        QTextStream stream(&file);
        stream.setCodec("UTF-8");
        stream << nomecognome << endl;
        stream << data << endl;
        stream << current_selected_row << endl;
    }

}

/**
 * @brief GrowcutGUI::aggiornaPreview
 * @param where
 * @param opencvimage
 * Questo metodo aggiorna il contenuto grafico dell'anteprima con un'immagine di tipo cv::Mat
 */


void GrowcutGUI::aggiornaPreview(ClickableLabel *where, Mat opencvimage)
{

    QImage q_image = mat2Image_shared(opencvimage);
    QPixmap p_image = QPixmap::fromImage(q_image);
    where->setPixmap(p_image);
    where->show();
}

void GrowcutGUI::on_patologiaLista_clicked(const QModelIndex &index)
{
    index.data();
}

int GrowcutGUI::getScaleFactorCols()
{
    return scaleFactorCols;
}

int GrowcutGUI::getScaleFactorRows()
{
    return scaleFactorRows;
}

void GrowcutGUI::setAnteprimaOriginale(const Mat opencvimg)
{
    mat_anteprima_originale = opencvimg;
    aggiornaPreview(ui->anteprima_originale,mat_anteprima_originale);
}

void GrowcutGUI::setAnteprimaSana(const Mat opencvimg)
{
    mat_anteprima_sana = opencvimg;
    aggiornaPreview(ui->anteprima_sana,mat_anteprima_sana);
}

void GrowcutGUI::setAnteprimaMalata(const Mat opencvimg)
{
    mat_anteprima_malata = opencvimg;
    aggiornaPreview(ui->anteprima_malata,mat_anteprima_malata);
}

void GrowcutGUI::on_actionSegmenta_ora_triggered()
{
    Mat mask = labelset;
    //grabCut( mat_anteprima_originale, mask, bgdModel, fgdModel, 1, GC_INIT_WITH_MASK );
}

void GrowcutGUI::on_actionSalva_lavoro_rapidamente_triggered()
{
    // salva lavoro rapidamente
}

void GrowcutGUI::keyPressEvent(QKeyEvent* keyevent) { }

void GrowcutGUI::keyReleaseEvent(QKeyEvent * keyevent)
{
    switch(keyevent->key())
    {
        case Qt::Key_A:
            on_actionApri_immagine_triggered();
            break;
        default:
            break;
    }

}

void GrowcutGUI::on_actionRitaglia_immagine_triggered()
{
    // ritaglia immagine
	cropMode = true;

}

bool GrowcutGUI::getCropMode()
{
	return cropMode;
}
