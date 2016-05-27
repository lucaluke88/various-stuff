/****************************************************************************
** Meta object code from reading C++ file 'growcutgui.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../GrowcutQTGui/growcutgui.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'growcutgui.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_GrowcutGUI_t {
    QByteArrayData data[13];
    char stringdata0[270];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_GrowcutGUI_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_GrowcutGUI_t qt_meta_stringdata_GrowcutGUI = {
    {
QT_MOC_LITERAL(0, 0, 10), // "GrowcutGUI"
QT_MOC_LITERAL(1, 11, 32), // "on_actionApri_immagine_triggered"
QT_MOC_LITERAL(2, 44, 0), // ""
QT_MOC_LITERAL(3, 45, 29), // "on_confermaDatibutton_clicked"
QT_MOC_LITERAL(4, 75, 25), // "on_patologiaLista_clicked"
QT_MOC_LITERAL(5, 101, 5), // "index"
QT_MOC_LITERAL(6, 107, 31), // "on_actionSegmenta_ora_triggered"
QT_MOC_LITERAL(7, 139, 13), // "keyPressEvent"
QT_MOC_LITERAL(8, 153, 10), // "QKeyEvent*"
QT_MOC_LITERAL(9, 164, 8), // "keyevent"
QT_MOC_LITERAL(10, 173, 15), // "keyReleaseEvent"
QT_MOC_LITERAL(11, 189, 43), // "on_actionSalva_lavoro_rapidam..."
QT_MOC_LITERAL(12, 233, 36) // "on_actionRitaglia_immagine_tr..."

    },
    "GrowcutGUI\0on_actionApri_immagine_triggered\0"
    "\0on_confermaDatibutton_clicked\0"
    "on_patologiaLista_clicked\0index\0"
    "on_actionSegmenta_ora_triggered\0"
    "keyPressEvent\0QKeyEvent*\0keyevent\0"
    "keyReleaseEvent\0"
    "on_actionSalva_lavoro_rapidamente_triggered\0"
    "on_actionRitaglia_immagine_triggered"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_GrowcutGUI[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x08 /* Private */,
       3,    0,   55,    2, 0x08 /* Private */,
       4,    1,   56,    2, 0x08 /* Private */,
       6,    0,   59,    2, 0x08 /* Private */,
       7,    1,   60,    2, 0x08 /* Private */,
      10,    1,   63,    2, 0x08 /* Private */,
      11,    0,   66,    2, 0x08 /* Private */,
      12,    0,   67,    2, 0x08 /* Private */,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QModelIndex,    5,
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 8,    9,
    QMetaType::Void, 0x80000000 | 8,    9,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void GrowcutGUI::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        GrowcutGUI *_t = static_cast<GrowcutGUI *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->on_actionApri_immagine_triggered(); break;
        case 1: _t->on_confermaDatibutton_clicked(); break;
        case 2: _t->on_patologiaLista_clicked((*reinterpret_cast< const QModelIndex(*)>(_a[1]))); break;
        case 3: _t->on_actionSegmenta_ora_triggered(); break;
        case 4: _t->keyPressEvent((*reinterpret_cast< QKeyEvent*(*)>(_a[1]))); break;
        case 5: _t->keyReleaseEvent((*reinterpret_cast< QKeyEvent*(*)>(_a[1]))); break;
        case 6: _t->on_actionSalva_lavoro_rapidamente_triggered(); break;
        case 7: _t->on_actionRitaglia_immagine_triggered(); break;
        default: ;
        }
    }
}

const QMetaObject GrowcutGUI::staticMetaObject = {
    { &QMainWindow::staticMetaObject, qt_meta_stringdata_GrowcutGUI.data,
      qt_meta_data_GrowcutGUI,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *GrowcutGUI::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *GrowcutGUI::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_GrowcutGUI.stringdata0))
        return static_cast<void*>(const_cast< GrowcutGUI*>(this));
    return QMainWindow::qt_metacast(_clname);
}

int GrowcutGUI::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QMainWindow::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
