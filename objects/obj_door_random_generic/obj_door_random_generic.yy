{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "obj_door_random_generic",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":2,"eventType":3,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":8,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":12,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_actor_3d_generic","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"propertyId":{"name":"collidable","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"value":"True",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_interactable_generic","path":"objects/obj_interactable_generic/obj_interactable_generic.yy",},"propertyId":{"name":"interaction_default","path":"objects/obj_interactable_generic/obj_interactable_generic.yy",},"value":"interactions.use",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_actor_3d_generic","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"propertyId":{"name":"dynamic","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"value":"True",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_actor_3d_generic","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"propertyId":{"name":"lighting_enabled","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"value":"True",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_actor_3d_generic","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"propertyId":{"name":"zrotation","path":"objects/obj_actor_3d_generic/obj_actor_3d_generic.yy",},"value":"image_angle+90",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"obj_interactable_generic","path":"objects/obj_interactable_generic/obj_interactable_generic.yy",},"propertyId":{"name":"name","path":"objects/obj_interactable_generic/obj_interactable_generic.yy",},"value":"\"door\"",},
  ],
  "parent": {
    "name": "doors",
    "path": "folders/Objects/generic/doors.yy",
  },
  "parentObjectId": {
    "name": "obj_door_generic",
    "path": "objects/obj_door_generic/obj_door_generic.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"draw_back","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"True","varType":3,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"player_pass_through_auto","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"True","varType":3,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"being_used","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0","varType":3,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"number_side","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"-1","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"door_number","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"-1","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"mirrored","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"0","varType":3,},
  ],
  "solid": false,
  "spriteId": null,
  "spriteMaskId": null,
  "visible": true,
}