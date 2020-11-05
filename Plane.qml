import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: rOOT
    pivot: nose_Cone.position

    Model {
        id: fuselage
        x: -0.000442874
        y: 0.995229
        z: -0.954944
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.0753849
        scale.y: 0.0915384
        scale.z: 0.125727
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/fuselage.mesh"

        PrincipledMaterial {
            id: fuselage_Material_material
            baseColorMap: Texture {
                source: "file:/home/polto/QT_3D_MODELS/Plane/maps/0.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
            opacityChannel: Material.A
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            fuselage_Material_material
        ]
    }


    Model {
        id: wing
        x: -0.00050568
        y: 1.03481
        z: -0.812004
        eulerRotation.x: -0.0578991
        eulerRotation.y: 0.0224262
        eulerRotation.z: -90.1724
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/wing.mesh"

        PrincipledMaterial {
            id: wing_Material_material
            baseColorMap: Texture {
                source: "file:/home/polto/QT_3D_MODELS/Plane/maps/1.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
            opacityChannel: Material.A
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            wing_Material_material
        ]
    }

    Model {
        id: stabilizer
        x: 0.000948155
        y: 0.958687
        z: -1.28099
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/stabilizer.mesh"

        PrincipledMaterial {
            id: stab_Material_material
            baseColorMap: Texture {
                source: "file:/home/polto/QT_3D_MODELS/Plane/maps/2.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
            opacityChannel: Material.A
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            stab_Material_material
        ]
    }

    Model {
        id: fin
        x: 0.000520868
        y: 1.0472
        z: -1.25758
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/fin.mesh"

        PrincipledMaterial {
            id: fin_Material_material
            baseColorMap: Texture {
                source: "file:/home/polto/QT_3D_MODELS/Plane/maps/3.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
            opacityChannel: Material.A
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            fin_Material_material
        ]
    }

    Model {
        id: left_Tire
        x: 0.104861
        y: 0.887764
        z: -0.726333
        eulerRotation.x: 0.0576904
        eulerRotation.y: -0.0224779
        eulerRotation.z: 89.8473
        scale.x: 0.0262255
        scale.y: 0.107023
        scale.z: 0.0261553
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/left_Tire.mesh"

        PrincipledMaterial {
            id: tire_Material_material
            baseColorMap: Texture {
                source: "file:/home/polto/QT_3D_MODELS/Plane/maps/4.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
            opacityChannel: Material.A
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            tire_Material_material
        ]
    }

    Model {
        id: tail_Skid
        x: 0.00128693
        y: 0.943418
        z: -1.26937
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.00299766
        scale.y: 0.012548
        scale.z: 0.0476565
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/tail_Skid.mesh"

        PrincipledMaterial {
            id: tail_Skid_Material_material
            baseColor: "#ff000000"
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            tail_Skid_Material_material
        ]
    }

    Model {
        id: right_Tire
        x: -0.103197
        y: 0.888216
        z: -0.726123
        eulerRotation.x: 0.0576904
        eulerRotation.y: -0.0224779
        eulerRotation.z: 89.8473
        scale.x: 0.0262255
        scale.y: 0.107023
        scale.z: 0.0261553
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/right_Tire.mesh"
        materials: [
            tire_Material_material
        ]
    }

    Model {
        id: landing_Gear
        x: 0.00128063
        y: 0.920693
        z: -0.726139
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.034014
        scale.y: 0.0340139
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/landing_Gear.mesh"

        PrincipledMaterial {
            id: landing_Gear_Material_material
            baseColor: "#ff000000"
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            landing_Gear_Material_material
        ]
    }

    Model {
        id: prop_1
        x: 0.000460774
        y: 0.952572
        z: -0.574846
        eulerRotation.x: -0.0224359
        eulerRotation.y: -0.0577731
        eulerRotation.z: 179.828
        scale.x: -0.023974
        scale.y: -0.182852
        scale.z: -0.00954234
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/prop_1.mesh"

        PrincipledMaterial {
            id: prop_1_Material_material
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            prop_1_Material_material
        ]
    }

    Model {
        id: prop_2
        x: 0.000786364
        y: 1.02883
        z: -0.574817
        eulerRotation.x: 0.022434
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172577
        scale.x: -0.023974
        scale.y: -0.182852
        scale.z: -0.00954234
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/prop_2.mesh"

        PrincipledMaterial {
            id: prop_2_Material_material
            baseColor: "#ff000000"
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            prop_2_Material_material
        ]
    }

    Model {
        id: nose_Cone
        x: 0.000706432
        y: 0.990806
        z: -0.571958
        eulerRotation.x: 90.0225
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.0131689
        scale.y: 0.182852
        scale.z: 0.0131689
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/nose_Cone.mesh"

        PrincipledMaterial {
            id: nose_Cone_Material_material
            baseColorMap: Texture {
                source: "file:/home/polto/QT_3D_MODELS/Plane/maps/5.png"
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
            }
            opacityChannel: Material.A
            metalness: 0
            roughness: 0.5
            cullMode: Material.NoCulling
        }
        materials: [
            nose_Cone_Material_material
        ]
    }

    Model {
        id: aileron_Left
        x: 0.382969
        y: 1.03229
        z: -0.929705
        eulerRotation.x: -0.0578991
        eulerRotation.y: 0.0224262
        eulerRotation.z: -90.1724
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/aileron_Left.mesh"
        materials: [
            wing_Material_material
        ]
    }

    Model {
        id: aileron_Right
        x: -0.384342
        y: 1.0346
        z: -0.927853
        eulerRotation.x: -0.0578991
        eulerRotation.y: 0.0224262
        eulerRotation.z: -90.1724
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/aileron_Right.mesh"
        materials: [
            wing_Material_material
        ]
    }

    Model {
        id: elevator
        x: 0.000831502
        y: 0.958715
        z: -1.35076
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/elevator.mesh"
        materials: [
            stab_Material_material
        ]
    }

    Model {
        id: rudder
        x: 0.000180097
        y: 1.04724
        z: -1.35925
        eulerRotation.x: 0.0224359
        eulerRotation.y: 0.0577731
        eulerRotation.z: -0.172444
        scale.x: 0.182852
        scale.y: 0.182852
        scale.z: 0.182852
        source: "file:/home/polto/QT_3D_MODELS/Plane/meshes/rudder.mesh"
        materials: [
            fin_Material_material
        ]
    }

}
