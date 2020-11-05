#include "rqtphysics.h"


QMap<QQuick3DNode*,RigidBody*> *_action_bodies  = new QMap<QQuick3DNode*,RigidBody*>;
QMap<QQuick3DNode*,RigidBody*> *_simuation_bodies  = new QMap<QQuick3DNode*,RigidBody*>;

QSet<RigidBody*> *rigidBodyToDelete = new QSet<RigidBody*>;
unsigned int _hitted_bodies = 0;

QList<RigidBody*> *_explode_bodies = new QList<RigidBody*>;


PhysicsCommon *physicsCommon = new PhysicsCommon;

RQtPhysicsEventListener listener;

PhysicsWorld*  world = 0;



// Create the physics world with your settings

RQtPhysics::RQtPhysics(QObject *parent):
    QThread(parent)
{
    mutex = new QMutex;
    _staticRigidBodies = new QList<QQuick3DNode*>;
    _dynamicRigidBodies = new QList<QQuick3DNode*>;
    _controller_rigid_body = 0;
    _controller_body = 0;

    //    // Create the world settings
    PhysicsWorld::WorldSettings settings;
    settings.defaultVelocitySolverNbIterations = 20;
    settings.isSleepingEnabled = false;
    settings.gravity = Vector3(0, -9.81, 0);

    // Create the physics world with your settings
    world  = physicsCommon->createPhysicsWorld(settings);
    world->setEventListener(&listener);

}

RQtPhysics::~RQtPhysics()
{

}

QList<QQuick3DNode*> RQtPhysics::staticRigidBodies()
{
    return *_staticRigidBodies;
}

QList<QQuick3DNode*> RQtPhysics::dynamicRigidBodies()
{
    return *_dynamicRigidBodies;
}


void RQtPhysics::setStaticRigidBodies(QList<QQuick3DNode*> bs)
{
    _staticRigidBodies->clear();
    foreach(QQuick3DNode *_b, bs){
        _staticRigidBodies->append(_b);
        Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
        qDebug() << position.x << " :: "<< position.y << " :: "<< position.z;
        Quaternion orientation( _b->rotation().x()  ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
        Transform transform(position, orientation);
        RigidBody* body = world->createRigidBody(transform);
        body->setType(BodyType::STATIC);
        body->enableGravity(true);

        const Vector3 halfExtents(_b->scale().x() * 50.0 ,_b->scale().y() * 50.0 ,_b->scale().z() * 50.0 );
        BoxShape* boxShape = physicsCommon->createBoxShape(halfExtents);
        Transform transform2 = Transform::identity();
        body->addCollider(boxShape,transform2);
    }
}

void RQtPhysics::addStaticRigidBody(QQuick3DNode *_b)
{
    _staticRigidBodies->append(_b);
    Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
    qDebug() << position.x << " :: "<< position.y << " :: "<< position.z;
    Quaternion orientation( _b->rotation().x() ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
    Transform transform(position, orientation);

    RigidBody* body = world->createRigidBody(transform);
    body->setType(BodyType::STATIC);
    body->enableGravity(true);

    const Vector3 halfExtents(_b->scale().x() * 50.0 ,_b->scale().y() * 50.0 ,_b->scale().z() * 50.0 );
    BoxShape* boxShape = physicsCommon->createBoxShape(halfExtents);
    Transform transform2 = Transform::identity();
    body->addCollider(boxShape,transform2);
}


void RQtPhysics::setDynamicRigidBodies(QList<QQuick3DNode*> bs)
{
    _dynamicRigidBodies->clear();
    foreach(QQuick3DNode *_b, bs){
        _dynamicRigidBodies->append(_b);
        Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
        Quaternion orientation( _b->rotation().x() ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
        Transform transform(position, orientation);
        RigidBody* body = world->createRigidBody(transform);
        const Vector3 halfExtents(_b->scale().x() * 50.0 ,_b->scale().y() * 50.0 ,_b->scale().z() * 50.0 );
        BoxShape* boxShape = physicsCommon->createBoxShape(halfExtents);
        Transform transform2 = Transform::identity();
        body->addCollider(boxShape,transform2);
        body->enableGravity(true);
        _simuation_bodies->insert(_b,body);
    }
}


void RQtPhysics::addDynamicRigidBody(QQuick3DNode *_b)
{
    _dynamicRigidBodies->append(_b);
    Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
    Quaternion orientation( _b->rotation().x() ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
    Transform transform(position, orientation);
    RigidBody* body = world->createRigidBody(transform);
    const Vector3 halfExtents(_b->scale().x() * 50.0 ,_b->scale().y() * 50.0 ,_b->scale().z() * 50.0 );
    BoxShape* boxShape = physicsCommon->createBoxShape(halfExtents);
    Transform transform2 = Transform::identity();
    body->addCollider(boxShape,transform2);
    body->enableGravity(true);

    _simuation_bodies->insert(_b,body);
}

void RQtPhysics::removeDynamicRigidBody(QQuick3DNode *_b)
{
    RigidBody* _r = _simuation_bodies->value(_b);
    _simuation_bodies->remove(_b);
    delete _b;
    rigidBodyToDelete->insert(_r);
}


void RQtPhysics::addControllerBody(QQuick3DNode *_b)
{
    _controller_body = _b;
    Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
    Quaternion orientation( _b->rotation().x() ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
    Transform transform(position, orientation);
    _controller_rigid_body = world->createRigidBody(transform);
    const Vector3 halfExtents(_b->scale().x() * 50.0 ,_b->scale().y() * 50.0 ,_b->scale().z() * 50.0 );
    BoxShape* boxShape = physicsCommon->createBoxShape(halfExtents);
    Transform transform2 = Transform::identity();
    _controller_rigid_body->addCollider(boxShape,transform2);
    _controller_rigid_body->enableGravity(true);
    _controller_rigid_body->setType(BodyType::STATIC);
}

void RQtPhysics::updateControllerBody()
{
    Vector3 position( _controller_body->position().x() ,_controller_body->position().y() ,_controller_body->position().z() );
    Quaternion orientation( _controller_body->rotation().x() ,_controller_body->rotation().y() ,_controller_body->rotation().z() ,_controller_body->rotation().scalar());
    Transform transform(position, orientation);
    _controller_rigid_body->setTransform(transform);
}

void RQtPhysics::addActionBody(QQuick3DNode *_b)
{
    Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
    Quaternion orientation( _b->rotation().x() ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
    Transform transform(position, orientation);
    RigidBody* _r = world->createRigidBody(transform);

    const Vector3 halfExtents(_b->scale().x() * 50.0 ,_b->scale().y() * 50.0 ,_b->scale().z() * 50.0 );
    BoxShape* boxShape = physicsCommon->createBoxShape(halfExtents);
    Transform transform2 = Transform::identity();
    _r->addCollider(boxShape,transform2);
    _r->enableGravity(false);
    _r->setMass(10.0);
    _r->setType(BodyType::STATIC);
    _action_bodies->insert(_b,_r);
}

void RQtPhysics::removeActionBody(QQuick3DNode *)
{

}

void RQtPhysics::updateActionBody()
{
    foreach( QQuick3DNode *_b, _action_bodies->keys()){
        Vector3 position( _b->position().x() ,_b->position().y() ,_b->position().z() );
        Quaternion orientation( _b->rotation().x() ,_b->rotation().y() ,_b->rotation().z() ,_b->rotation().scalar());
        Transform transform(position, orientation);
        _action_bodies->value(_b)->setTransform(transform);
    }
}

void RQtPhysics::run(){

    const double timeStep = 1.0 / 60.0;
    auto currentFrameTime = Clock::now();
    auto previousFrameTime = Clock::now();
    double mDeltaTime =0;
    double accumulator =0;
    while (1) {
        currentFrameTime = Clock::now();
        mDeltaTime  = std::chrono::duration_cast<std::chrono::milliseconds>(currentFrameTime - previousFrameTime).count()/1000.0;
        if(mDeltaTime > 0.2)
            mDeltaTime = 0.2;
        accumulator += mDeltaTime;
        while (accumulator >= timeStep) {
            if(world != 0)
                world->update(timeStep);
            accumulator -= timeStep;
            previousFrameTime = currentFrameTime;
            foreach( QQuick3DNode *_b, _simuation_bodies->keys()){

                Vector3 vec = _simuation_bodies->value(_b)->getTransform().getPosition();
                Quaternion rot = _simuation_bodies->value(_b)->getTransform().getOrientation();
                _b->setPosition(QVector3D(vec.x,vec.y,vec.z));
                _b->setRotation(QQuaternion(rot.x,rot.y,rot.z,rot.w));
            }
        }
    }
}

void RQtPhysics::update()
{
    foreach(RigidBody* _r , *_explode_bodies){
        Transform transform = _r->getTransform();
        Vector3 vec = transform.getPosition();
        vec.y += 5.0;
        transform.setPosition(vec);
        _r->setTransform(transform);

        if(vec.y > 300.0){
            qDebug() << _r << "deleted ";
            _explode_bodies->removeAll(_r);
            rigidBodyToDelete->insert(_r);
        }
    }

    const double timeStep = 1.0 / 60.0;

    world->update(timeStep);

    foreach(RigidBody* _r , *rigidBodyToDelete){
        world->destroyRigidBody(_r);
    }
    rigidBodyToDelete->clear();



    foreach( QQuick3DNode *_b, _simuation_bodies->keys()){
        Vector3 vec = _simuation_bodies->value(_b)->getTransform().getPosition();
        Quaternion rot = _simuation_bodies->value(_b)->getTransform().getOrientation();
        _b->setPosition(QVector3D(vec.x,vec.y,vec.z));
        _b->setRotation(QQuaternion(rot.x,rot.y,rot.z,rot.w));
    }
    emit hittedBodies(_hitted_bodies);

}




// listener class

void RQtPhysicsEventListener::onContact(const CollisionCallback::CallbackData &callbackData)
{
    for (uint p = 0; p < callbackData.getNbContactPairs(); p++) {
        // Get the contact pair
        CollisionCallback::ContactPair contactPair = callbackData.getContactPair(p);
        if(_action_bodies->values().contains(( RigidBody* )contactPair.getBody1())){

            CollisionCallback::ContactPoint contactPoint = contactPair.getContactPoint(0);
            Vector3 worldPoint = contactPair.getCollider1()->getLocalToWorldTransform()
                    * contactPoint.getLocalPointOnCollider1();
            QQuick3DNode *_b1a = _action_bodies->key(( RigidBody* )contactPair.getBody1());
            QQuick3DNode *_b2s = _simuation_bodies->key(( RigidBody* )contactPair.getBody2());
            _action_bodies->remove(_b1a);
            rigidBodyToDelete->insert(( RigidBody* )contactPair.getBody1());
            _hitted_bodies++;

            if(_b1a->objectName() == "bullet") {
                 _simuation_bodies->remove(_b2s);
                  delete _b2s;
                rigidBodyToDelete->insert(( RigidBody* )contactPair.getBody2());
            }
            else if(_b1a->objectName() == "missle") {
                Vector3 position( worldPoint.x ,-100.0 ,worldPoint.z);
                Quaternion orientation( 0.0,0.0,0.0 , 1.0);
                Transform transform(position, orientation);
                RigidBody* _er = world->createRigidBody(transform);
                _er->enableGravity(false);
                SphereShape* sphereShape = physicsCommon->createSphereShape(50.0 );
                Transform transform2 = Transform::identity();
                _er->setType(BodyType::STATIC);

                _er->addCollider(sphereShape,transform2);

                SphereShape* sphereShape2 = physicsCommon->createSphereShape(130.0 );
                Transform transform3 = Transform::identity();
                Vector3 vec = transform3.getPosition();
                vec.y=-200;
                transform3.setPosition(vec);
                _er->setType(BodyType::STATIC);

                _er->addCollider(sphereShape2,transform3);
                _explode_bodies->append(_er);
            }
            delete _b1a;

        }
    }
}
