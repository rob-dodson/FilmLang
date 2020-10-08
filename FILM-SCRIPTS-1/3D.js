let width = 350
let height = 250

let scene =
{
	type:SCENEVIEW,
	name:"sceneview",
	x:10,
	y:10,
	width:width,
	height:height,
	layoutSpec:{x:2,y:2,fit:false},
	objectFilePath:"/Users/robertdodson/Desktop/FILM/teapot.obj",
    objectScale:{x:50,y:50,z:50},
    objectPosition:{x:width/2,y:height/3,z:50},
	objectColor:cyan,
    cameraPosition:{x:width/2,y:height/2,z:350},
    lightPosition:{x:50,y:height,z:100},
}
addBlock(scene)
