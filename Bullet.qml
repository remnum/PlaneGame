import QtQuick 2.0
import QtQuick3D 1.15


Model{
    id:root
    objectName: "bullet"
    source: "#Cube"
    property bool init_shoot:false
    scale: Qt.vector3d(0.5,0.1,0.1)

    Model {
        id: cylinder_001
        scale.x: 0.1
        scale.y: 0.1
        scale.z: 0.03
        eulerRotation.y:90

        source: "file:/home/polto/QT_3D_MODELS/AVMT300/meshes/cylinder_001.mesh"

        DefaultMaterial {
            id: material_001_material
            diffuseColor: "#000000"
        }
        materials: [
            material_001_material,
            material_001_material,
            material_001_material
        ]
    }


    function negate(vector) {
        return Qt.vector3d(-vector.x, -vector.y, -vector.z)
    }

    function updatePosition(vector, speed, position)
    {
        var direction = vector;
        var velocity = Qt.vector3d(direction.x * speed,
                                   direction.y * speed,
                                   direction.z * speed);
        root.position = Qt.vector3d(position.x + velocity.x,
                                                position.y + velocity.y,
                                                position.z + velocity.z);
    }

    function fire(){
        if(!init_shoot){
            init_shoot = true
            root.rotate(10,Qt.vector3d(1.0,1.0,0.0),Node.LocalSpace);
        }
      updatePosition(root.right , 8, root.position);
    }

    Timer{
        interval: 10
        running: true
        repeat: true
        onTriggered:
            fire()
    }

}

