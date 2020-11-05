import QtQuick 2.0
import QtQuick3D 1.15


Model{
    source: "#Cube"
    scale: Qt.vector3d(0.08,0.04,0.12)

    DefaultMaterial {
        id:material1
//        diffuseColor: Qt.rgba(Math.floor(Math.random()*255)/255
//                              ,Math.floor(Math.random()*255)/255
//                              ,Math.floor(Math.random()*255)/255
//                              ,1.0
//                              )

        diffuseColor: Qt.rgba(0.75 ,0.0 ,0.0 ,1.0 )
    }
    materials: [material1]
}

