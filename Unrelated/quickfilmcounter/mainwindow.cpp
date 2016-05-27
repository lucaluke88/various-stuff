#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_clicked()
{
    ore = ui->lineEdit->text().toInt();
    minuti = ui->lineEdit_2->text().toInt();
    velocita = ui->lineEdit_3->text().toFloat();
    // calcolo nuovo tempo
    int tempo_in_secondi = ore*60 + minuti;

    int nuovo_tempo_in_secondi = tempo_in_secondi/velocita;

    int n_ore = (int) nuovo_tempo_in_secondi/60;
    int n_minuti = nuovo_tempo_in_secondi%60;
    QString new_time = QString::number(n_ore)+":"+QString::number(n_minuti);

    ui->label_3->setText(new_time);
}



