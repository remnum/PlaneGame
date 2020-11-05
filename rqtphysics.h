#ifndef RQTPHYSICS_H
#define RQTPHYSICS_H

#include "RQtPhysics_global.h"
#include <QThread>
#include <QList>
#include <QSet>
#include <QVector3D>
#include <QDebug>
#include <QtQuick3D/private/qquick3dnode_p.h>
#include <QtQuick3D>
#include <QDebug>


//physics engine
#include <reactphysics3d/reactphysics3d.h>
using namespace reactphysics3d;

typedef std::chrono::high_resolution_clock Clock;

class RQtPhysicsEventListener : public EventListener {
    // Override the onContact() method
    virtual void onContact(const CollisionCallback::CallbackData& callbackData);


};

class RQtPhysics :public QThread
{
    Q_OBJECT
    Q_PROPERTY(QList<QQuick3DNode*> staticRigidBodies READ staticRigidBodies WRITE setStaticRigidBodies NOTIFY staticRigidBodiesChanged)
    Q_PROPERTY(QList<QQuick3DNode*> dynamicRigidBodies READ dynamicRigidBodies WRITE setDynamicRigidBodies NOTIFY dynamicRigidBodiesChanged)

public:
    RQtPhysics(QObject *parent=0);
    ~RQtPhysics();
    void run();

signals:
    void staticRigidBodiesChanged();
    void dynamicRigidBodiesChanged();
    void hittedBodies(int hits);

public slots:
    void update();

    QList<QQuick3DNode*> staticRigidBodies();
    void setStaticRigidBodies(QList<QQuick3DNode*>);
    void addStaticRigidBody(QQuick3DNode*);

    QList<QQuick3DNode*> dynamicRigidBodies();
    void setDynamicRigidBodies(QList<QQuick3DNode*>);
    void addDynamicRigidBody(QQuick3DNode*);
    void removeDynamicRigidBody(QQuick3DNode  *);

    void addActionBody(QQuick3DNode  *);
    void removeActionBody(QQuick3DNode  *);
    void updateActionBody();

    void addControllerBody(QQuick3DNode  *);
    void updateControllerBody();
private:
    QList<QQuick3DNode*> *_staticRigidBodies;
    QList<QQuick3DNode*> *_dynamicRigidBodies;

    QQuick3DNode  *_controller_body;
    RigidBody *_controller_rigid_body;


    QMutex *mutex;

};

#endif // RQTPHYSICS_H
