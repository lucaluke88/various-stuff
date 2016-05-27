#include "growcutgui.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    GrowcutGUI w;
    w.show();

    return a.exec();
}

