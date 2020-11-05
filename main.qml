import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick3D 1.15
import QtQuick3D.Helpers 1.15
import RQtPhysics 1.0

Window {
    visible: true
    width: 640
    height: 480
    visibility: Window.FullScreen
    title: qsTr("Hello World")

    property int i:0
    property var wall_objs:[]
    Image {
        id: land_texture
        anchors.fill: parent
        source: "file:/home/polto/QT_3D_MODELS/images/sky.jpg"
    }

    Image {
        id: streets_texture
        anchors.bottom: parent.top
        anchors.right: parent.left
        source: "file:/home/polto/QT_3D_MODELS/images/streets.jpg"
    }


    View3D {
        id:view
        anchors.fill: parent
        focus: true
        antialiasing: true

        PerspectiveCamera {
            id:cam
            position: Qt.vector3d(0.0,250.0,300.0)
            eulerRotation: Qt.vector3d(-45.0,0.0,0.0)
        }

        PointLight{
            position: Qt.vector3d(0.0,100.0,0.0)
            brightness: 500
        }
        SpotLight{
            position: Qt.vector3d(0.0,100.0,0.0)
            eulerRotation.x:220

            brightness: 200
            color: "cyan"
            coneAngle : 40
            constantFade : 1.0
            innerConeAngle : 30
            linearFade : 1.0
            quadraticFade : 0.0

            NumberAnimation on eulerRotation.y {
                from :360
                to :0
                running: true
                duration: 16000
                loops:1
                onFinished: {
                    var _to = to
                    to = from
                    from = _to
                    restart()
                }
            }
        }


        SpotLight{
            position: Qt.vector3d(0.0,100.0,0.0)
            eulerRotation.x:220

            brightness: 200
            color: "white"
            coneAngle : 40
            constantFade : 1.0
            innerConeAngle : 30
            linearFade : 1.0
            quadraticFade : 0.0

            NumberAnimation on eulerRotation.y {
                from :0
                to :360
                running: true
                duration: 16000
                loops:1
                onFinished: {
                    var _to = to
                    to = from
                    from = _to
                    restart()
                }
            }
        }

        environment: SceneEnvironment {
            id: sceneEnvironment
            clearColor: "#000000"

            backgroundMode: SceneEnvironment.Transparent
            lightProbe: Texture {
                source: "file:/home/polto/QT_3D_MODELS/maps/colorful_studio_1k.hdr"

            }
        }

        Model{
            id: street_land
            source: "#Cube"
            position: Qt.vector3d(0.0,0.0,0.0)
            scale: Qt.vector3d(4.0,0.01,4.0)
            pickable:true
            DefaultMaterial {
                id: street_land_mat
                diffuseMap: Texture{
                    sourceItem: streets_texture
                }

                specularAmount: 1.0
            }
            materials: [street_land_mat]
        }

        Plane3{
            id:model_plane
            position: Qt.vector3d(0.0,10.0,-200.0)
            scale: Qt.vector3d(50.0,50.0,50.0)
        }

        Model{
            id:plane_bound
            source: "#Cube"
            position: Qt.vector3d(model_plane.x,model_plane.y,model_plane.z)
            eulerRotation: model_plane.eulerRotation
            scale: Qt.vector3d(0.8,0.2,1.0)
            //            materials: [PrincipledMaterial{
            //                baseColor: "red"
            //                }]
        }



        Node{
            id:mynode
        }


        PlaneController{
            controlledObject: model_plane
            speed: 0.5
            leftSpeed: 2.0
            rightSpeed: 2.0
            onEmitFire:
                plane_shoot();
            onEmitMissle:
                plane_shoot_missle();
        }


    }

    RQtPhysics{
        id:phy
        onHittedBodies:
            hit_count.text = "Score : " + hits
    }

    function plane_shoot() {
        var plane_position = plane_bound.position
        var plane_eulerRotation_y = model_plane.eulerRotation.y
        var obj = Qt.createQmlObject("Bullet{position:Qt.vector3d("+plane_bound.position.x+","+plane_bound.position.y+","+plane_bound.position.z+");"+
                                     "eulerRotation.y:"+plane_eulerRotation_y+";}",mynode,"missle");
        hit_type.color= "white"
        hit_type.text = "Bullets"
        phy.addActionBody(obj);
    }

    function plane_shoot_missle() {
        var plane_position = plane_bound.position
        var plane_eulerRotation_y = model_plane.eulerRotation.y
        var obj = Qt.createQmlObject("Missle{position:Qt.vector3d("+plane_bound.position.x+","+plane_bound.position.y+","+plane_bound.position.z+");"+
                                     "eulerRotation.y:"+plane_eulerRotation_y+";}",mynode,"missle");
        hit_type.color= "red"
        hit_type.text = "Missle"
        phy.addActionBody(obj);
    }

    function createWall() {
        var objs = []
        for(var col=0;col<8;col++){
            for(var row=0;row<24;row++){
                var obj = Qt.createQmlObject("Brick{position: Qt.vector3d(-100.0 +"+(row*8+0.5)+",1.0+"+col*4+",0.0);}",mynode,"cube"+i);
                objs.push(obj)
                wall_objs.push(obj)
            }
        }
        phy.dynamicRigidBodies = objs
    }



    Component.onCompleted: {
        phy.addStaticRigidBody(street_land)
        phy.addControllerBody(plane_bound)
        createWall();
    }

    Timer {
        id:phyTimer
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            phy.updateControllerBody()
            phy.update()
            phy.updateActionBody()
        }
    }


    Text {
        id: hit_type
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        width: 100
        height: 60
        text: ""
        font.pixelSize: 40
        color: "white"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }


    Text {
        id: hit_count
//        anchors.top: parent.top
//        anchors.horizontalCenter: parent.horizontalCenter
        width: 100
        height: 60
        text: "0"
        color: "white"
        font.pixelSize: 60
        verticalAlignment: Text.AlignVCenter
    }
}

