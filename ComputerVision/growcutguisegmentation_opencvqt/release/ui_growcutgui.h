/********************************************************************************
** Form generated from reading UI file 'growcutgui.ui'
**
** Created by: Qt User Interface Compiler version 5.5.1
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_GROWCUTGUI_H
#define UI_GROWCUTGUI_H

#include <QtCore/QVariant>
#include <QtWidgets/QAction>
#include <QtWidgets/QApplication>
#include <QtWidgets/QButtonGroup>
#include <QtWidgets/QDateEdit>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QListWidget>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QMenu>
#include <QtWidgets/QMenuBar>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QStatusBar>
#include <QtWidgets/QWidget>
#include "clickablelabel.h"

QT_BEGIN_NAMESPACE

class Ui_GrowcutGUI
{
public:
    QAction *actionApri_immagine;
    QAction *actionApri_lavoro;
    QAction *actionSogliatura_preliminare;
    QAction *actionRitaglia_immagine;
    QAction *actionSegmenta_ora;
    QAction *actionSalva_lavoro_rapidamente;
    QAction *actionSalva_lavoro_con_nome;
    QAction *actionAnnulla_lavoro_e_ripristina;
    QWidget *centralWidget;
    QDateEdit *dateEdit;
    QLabel *label;
    QLabel *label_2;
    QListWidget *patologiaLista;
    QLineEdit *nomecognome_edit;
    QPushButton *confermaDatibutton;
    ClickableLabel *anteprima_originale;
    ClickableLabel *anteprima_sana;
    ClickableLabel *anteprima_malata;
    QLabel *immagine_info_label;
    QLabel *label_3;
    QLabel *istruzioni_label;
    QMenuBar *menuBar;
    QMenu *menuApri;
    QMenu *menuModifica;
    QMenu *menuSegmenta;
    QMenu *menuGestione_lavoro;
    QStatusBar *statusBar;

    void setupUi(QMainWindow *GrowcutGUI)
    {
        if (GrowcutGUI->objectName().isEmpty())
            GrowcutGUI->setObjectName(QStringLiteral("GrowcutGUI"));
        GrowcutGUI->resize(1190, 600);
        GrowcutGUI->setMaximumSize(QSize(1190, 600));
        actionApri_immagine = new QAction(GrowcutGUI);
        actionApri_immagine->setObjectName(QStringLiteral("actionApri_immagine"));
        actionApri_lavoro = new QAction(GrowcutGUI);
        actionApri_lavoro->setObjectName(QStringLiteral("actionApri_lavoro"));
        actionSogliatura_preliminare = new QAction(GrowcutGUI);
        actionSogliatura_preliminare->setObjectName(QStringLiteral("actionSogliatura_preliminare"));
        actionRitaglia_immagine = new QAction(GrowcutGUI);
        actionRitaglia_immagine->setObjectName(QStringLiteral("actionRitaglia_immagine"));
        actionSegmenta_ora = new QAction(GrowcutGUI);
        actionSegmenta_ora->setObjectName(QStringLiteral("actionSegmenta_ora"));
        actionSalva_lavoro_rapidamente = new QAction(GrowcutGUI);
        actionSalva_lavoro_rapidamente->setObjectName(QStringLiteral("actionSalva_lavoro_rapidamente"));
        actionSalva_lavoro_con_nome = new QAction(GrowcutGUI);
        actionSalva_lavoro_con_nome->setObjectName(QStringLiteral("actionSalva_lavoro_con_nome"));
        actionAnnulla_lavoro_e_ripristina = new QAction(GrowcutGUI);
        actionAnnulla_lavoro_e_ripristina->setObjectName(QStringLiteral("actionAnnulla_lavoro_e_ripristina"));
        centralWidget = new QWidget(GrowcutGUI);
        centralWidget->setObjectName(QStringLiteral("centralWidget"));
        dateEdit = new QDateEdit(centralWidget);
        dateEdit->setObjectName(QStringLiteral("dateEdit"));
        dateEdit->setGeometry(QRect(970, 80, 201, 24));
        dateEdit->setCalendarPopup(true);
        label = new QLabel(centralWidget);
        label->setObjectName(QStringLiteral("label"));
        label->setGeometry(QRect(970, 10, 201, 16));
        label_2 = new QLabel(centralWidget);
        label_2->setObjectName(QStringLiteral("label_2"));
        label_2->setGeometry(QRect(970, 60, 201, 16));
        patologiaLista = new QListWidget(centralWidget);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        new QListWidgetItem(patologiaLista);
        patologiaLista->setObjectName(QStringLiteral("patologiaLista"));
        patologiaLista->setGeometry(QRect(970, 110, 201, 71));
        patologiaLista->setVerticalScrollBarPolicy(Qt::ScrollBarAsNeeded);
        nomecognome_edit = new QLineEdit(centralWidget);
        nomecognome_edit->setObjectName(QStringLiteral("nomecognome_edit"));
        nomecognome_edit->setGeometry(QRect(970, 30, 201, 24));
        confermaDatibutton = new QPushButton(centralWidget);
        confermaDatibutton->setObjectName(QStringLiteral("confermaDatibutton"));
        confermaDatibutton->setGeometry(QRect(970, 190, 201, 21));
        anteprima_originale = new ClickableLabel(centralWidget);
        anteprima_originale->setObjectName(QStringLiteral("anteprima_originale"));
        anteprima_originale->setGeometry(QRect(20, 40, 301, 500));
        anteprima_sana = new ClickableLabel(centralWidget);
        anteprima_sana->setObjectName(QStringLiteral("anteprima_sana"));
        anteprima_sana->setGeometry(QRect(330, 40, 301, 500));
        anteprima_malata = new ClickableLabel(centralWidget);
        anteprima_malata->setObjectName(QStringLiteral("anteprima_malata"));
        anteprima_malata->setGeometry(QRect(640, 40, 301, 500));
        immagine_info_label = new QLabel(centralWidget);
        immagine_info_label->setObjectName(QStringLiteral("immagine_info_label"));
        immagine_info_label->setGeometry(QRect(970, 260, 201, 51));
        immagine_info_label->setAlignment(Qt::AlignLeading|Qt::AlignLeft|Qt::AlignTop);
        immagine_info_label->setWordWrap(true);
        label_3 = new QLabel(centralWidget);
        label_3->setObjectName(QStringLiteral("label_3"));
        label_3->setGeometry(QRect(970, 220, 201, 20));
        label_3->setAlignment(Qt::AlignCenter);
        istruzioni_label = new QLabel(centralWidget);
        istruzioni_label->setObjectName(QStringLiteral("istruzioni_label"));
        istruzioni_label->setGeometry(QRect(20, 10, 921, 17));
        GrowcutGUI->setCentralWidget(centralWidget);
        menuBar = new QMenuBar(GrowcutGUI);
        menuBar->setObjectName(QStringLiteral("menuBar"));
        menuBar->setGeometry(QRect(0, 0, 1190, 25));
        menuApri = new QMenu(menuBar);
        menuApri->setObjectName(QStringLiteral("menuApri"));
        menuModifica = new QMenu(menuBar);
        menuModifica->setObjectName(QStringLiteral("menuModifica"));
        menuSegmenta = new QMenu(menuBar);
        menuSegmenta->setObjectName(QStringLiteral("menuSegmenta"));
        menuGestione_lavoro = new QMenu(menuBar);
        menuGestione_lavoro->setObjectName(QStringLiteral("menuGestione_lavoro"));
        GrowcutGUI->setMenuBar(menuBar);
        statusBar = new QStatusBar(GrowcutGUI);
        statusBar->setObjectName(QStringLiteral("statusBar"));
        GrowcutGUI->setStatusBar(statusBar);

        menuBar->addAction(menuApri->menuAction());
        menuBar->addAction(menuModifica->menuAction());
        menuBar->addAction(menuSegmenta->menuAction());
        menuBar->addAction(menuGestione_lavoro->menuAction());
        menuApri->addAction(actionApri_immagine);
        menuApri->addAction(actionApri_lavoro);
        menuModifica->addAction(actionSogliatura_preliminare);
        menuModifica->addAction(actionRitaglia_immagine);
        menuSegmenta->addAction(actionSegmenta_ora);
        menuGestione_lavoro->addAction(actionSalva_lavoro_rapidamente);
        menuGestione_lavoro->addAction(actionSalva_lavoro_con_nome);
        menuGestione_lavoro->addSeparator();
        menuGestione_lavoro->addAction(actionAnnulla_lavoro_e_ripristina);

        retranslateUi(GrowcutGUI);

        QMetaObject::connectSlotsByName(GrowcutGUI);
    } // setupUi

    void retranslateUi(QMainWindow *GrowcutGUI)
    {
        GrowcutGUI->setWindowTitle(QApplication::translate("GrowcutGUI", "GrowcutGUI - Luca Costantino (Universit\303\240 di Catania)", 0));
        actionApri_immagine->setText(QApplication::translate("GrowcutGUI", "Apri immagine [A]", 0));
#ifndef QT_NO_TOOLTIP
        actionApri_immagine->setToolTip(QApplication::translate("GrowcutGUI", "si pu\303\262 aprire un'immagine anche col tasto A", 0));
#endif // QT_NO_TOOLTIP
        actionApri_lavoro->setText(QApplication::translate("GrowcutGUI", "Apri lavoro", 0));
        actionSogliatura_preliminare->setText(QApplication::translate("GrowcutGUI", "Sogliatura preliminare", 0));
        actionRitaglia_immagine->setText(QApplication::translate("GrowcutGUI", "Ritaglia immagine", 0));
        actionSegmenta_ora->setText(QApplication::translate("GrowcutGUI", "Segmenta ora", 0));
        actionSalva_lavoro_rapidamente->setText(QApplication::translate("GrowcutGUI", "Salva lavoro rapidamente", 0));
        actionSalva_lavoro_con_nome->setText(QApplication::translate("GrowcutGUI", "Salva lavoro con nome", 0));
        actionAnnulla_lavoro_e_ripristina->setText(QApplication::translate("GrowcutGUI", "Annulla lavoro corrente", 0));
        dateEdit->setDisplayFormat(QApplication::translate("GrowcutGUI", "dd/MM/yyyy", 0));
        label->setText(QApplication::translate("GrowcutGUI", "Nome e Cognome del paziente", 0));
        label_2->setText(QApplication::translate("GrowcutGUI", "Data", 0));

        const bool __sortingEnabled = patologiaLista->isSortingEnabled();
        patologiaLista->setSortingEnabled(false);
        QListWidgetItem *___qlistwidgetitem = patologiaLista->item(0);
        ___qlistwidgetitem->setText(QApplication::translate("GrowcutGUI", "Acne - Gravit\303\240 1", 0));
        QListWidgetItem *___qlistwidgetitem1 = patologiaLista->item(1);
        ___qlistwidgetitem1->setText(QApplication::translate("GrowcutGUI", "Acne - Gravit\303\240 2", 0));
        QListWidgetItem *___qlistwidgetitem2 = patologiaLista->item(2);
        ___qlistwidgetitem2->setText(QApplication::translate("GrowcutGUI", "Acne - Gravit\303\240 3", 0));
        QListWidgetItem *___qlistwidgetitem3 = patologiaLista->item(3);
        ___qlistwidgetitem3->setText(QApplication::translate("GrowcutGUI", "Dermatite - Gravit\303\240 1", 0));
        QListWidgetItem *___qlistwidgetitem4 = patologiaLista->item(4);
        ___qlistwidgetitem4->setText(QApplication::translate("GrowcutGUI", "Dermatite - Gravit\303\240 2", 0));
        QListWidgetItem *___qlistwidgetitem5 = patologiaLista->item(5);
        ___qlistwidgetitem5->setText(QApplication::translate("GrowcutGUI", "Dermatite - Gravit\303\240 3", 0));
        QListWidgetItem *___qlistwidgetitem6 = patologiaLista->item(6);
        ___qlistwidgetitem6->setText(QApplication::translate("GrowcutGUI", "Dermatite - Gravit\303\240 4", 0));
        QListWidgetItem *___qlistwidgetitem7 = patologiaLista->item(7);
        ___qlistwidgetitem7->setText(QApplication::translate("GrowcutGUI", "Ustione - Primo grado", 0));
        QListWidgetItem *___qlistwidgetitem8 = patologiaLista->item(8);
        ___qlistwidgetitem8->setText(QApplication::translate("GrowcutGUI", "Ustione - Secondo grado", 0));
        QListWidgetItem *___qlistwidgetitem9 = patologiaLista->item(9);
        ___qlistwidgetitem9->setText(QApplication::translate("GrowcutGUI", "Ustione - Terzo grado", 0));
        patologiaLista->setSortingEnabled(__sortingEnabled);

#ifndef QT_NO_TOOLTIP
        patologiaLista->setToolTip(QApplication::translate("GrowcutGUI", "Elenco delle patologie con cui si pu\303\262 classificare un'immagine", 0));
#endif // QT_NO_TOOLTIP
        confermaDatibutton->setText(QApplication::translate("GrowcutGUI", "Conferma", 0));
        anteprima_originale->setText(QString());
        anteprima_sana->setText(QString());
        anteprima_malata->setText(QString());
        immagine_info_label->setText(QString());
        label_3->setText(QApplication::translate("GrowcutGUI", "Nome del file", 0));
        istruzioni_label->setText(QString());
        menuApri->setTitle(QApplication::translate("GrowcutGUI", "Apri...", 0));
        menuModifica->setTitle(QApplication::translate("GrowcutGUI", "Modifica", 0));
        menuSegmenta->setTitle(QApplication::translate("GrowcutGUI", "Segmenta", 0));
        menuGestione_lavoro->setTitle(QApplication::translate("GrowcutGUI", "Gestione lavoro", 0));
    } // retranslateUi

};

namespace Ui {
    class GrowcutGUI: public Ui_GrowcutGUI {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_GROWCUTGUI_H
