import QtQuick 2.15
import QtQuick3D 1.15

Node {
    id: rOOT

    Model {
        id: grid
        source: "file:/home/polto/QT_3D_MODELS/Land/meshes/grid.mesh"

        DefaultMaterial{
            id :_material_001
            diffuseMap: Texture{
                sourceItem: land_texture
                pivotU: 0.0
                pivotV: 0.0
                positionU: 0.0
                positionV: 0.0
                tilingModeHorizontal: Texture.Repeat
                tilingModeVertical: Texture.Repeat
                scaleU: 1.0
                scaleV: 1.0
            }
        }

        PrincipledMaterial {
            id: _material
            roughness: 1
        }
        materials: [
            _material_001
        ]
    }
}
