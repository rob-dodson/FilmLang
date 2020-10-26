//
// constants
//
let RECT = "Rect"
let TEXT = "Text"
let GRID = "Grid"
let IMAGE = "Image"
let ARC = "Arc"
let CIRCLE = "Circle"
let LINE = "Line"
let PATH = "Path"
let BEZIER = "Bezier"
let AXIS = "Axis"
let LAYOUT = "LayoutGrid"
let METALVIEW = "MetalView"
let SCENEVIEW = "SceneView"
let SCROLLTEXT = "ScrollText"


let MainFont = "Courier"

//
// animation constants
//
let ROTATION    = "rotation"
let X           = "x"
let Y           = "y"
let STARTANGLE  = "startangle"
let ENDANGLE    = "endangle"
let STROKEWIDTH = "strokewidth"
let STROKEALPHA = "strokealpha"
let BOUNCE      = "bounce"
let INC         = "inc"
let DEC         = "dec"

//
// Colors
//
let red       = { red:.7, green:0.0, blue:0.0, alpha:0.8}
let blue      = { red: 0.0, green: 0.00, blue: 0.88, alpha: .7}
let cyan      = { red: 0.07, green: 0.61, blue: 0.65, alpha: .5}
let green     = { red:0.0, green:0.9, blue:0.0, alpha:0.8}
let darkgreen = { red:0.0, green:0.5, blue:0.0, alpha:0.4}
let gray      = { red:0.7, green:0.7, blue:0.7, alpha:0.6}
let orange    = { red: 0.76, green: 0.38, blue: 0.05, alpha: .8 }
let black     = { red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00 }
let white     = { red: 1.0, green: 1.0, blue: 1.0, alpha: 1.00 }

let camborder = {red:0.5, green:0.5, blue:0.5, alpha:0.7}
let camback   = {red:0.0, green:0.0, blue:0.4, alpha:0.6}
let camiconcolor = {red:0.09, green:0.09, blue:0.09, alpha:0.7}

//
// gradients
//
let blockbackgrad =
{
    startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6},
    endColor: {red:0.9, green:0.2, blue:0.2, alpha:0.4},
}
let redgrad =
{
    startColor: {red:1.0, green:0.0, blue:0.0, alpha:1.0},
    endColor: {red:0.0, green:1.0, blue:0.0, alpha:1.0},
}

let screen = 
{
	type:RECT,
	name:"Screen",
	gradientAngle:-50,
	strokeColor:orange,
	clip:true,
	fitToView:true,
	// animator0:{value:"x",amount:10,min:0,max:500,type:BOUNCE},
	// animator1:{value:"y",amount:10,min:0,max:500,type:BOUNCE},
	fillGradient: { startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6},endColor: {red:0.0, green:0.0, blue:0.0, alpha:0.4}},
}
addBlock(screen)


let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:100,
	y:100,
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	strokeColor:orange,
	strokeWidth:5,
	radius:4,

//	animator0:{value:"x",amount:10,min:0,max:500,type:BOUNCE},
//	animator1:{value:"width",amount:10,min:400,max:500,type:BOUNCE},
	childBlock0: {type:TEXT,name:"beztitle0",text:"BEZ-1",size:20,x:70,y:240,textColor:gray,font:"Futura",textColor:blue,strokeColor:orange,radius:4,padding:5},
//	childBlock1: {type:TEXT,name:"beztitle1",text:"BEZ-2",size:20,x:70,y:200,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,fillColor:red,padding:5},
//	childBlock2: {type:TEXT,name:"beztitle2",text:"BEZ-3",size:20,x:70,y:150,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5,rotation:0,},
////	childBlock3: {type:TEXT,name:"beztitle3",text:"FOO 0",size:20,x:70,y:90,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5,rotation:0,animator0:{value:"rotation",amount:1,min:0,max:360,type:BOUNCE}},
//	childBlock4: {type:RECT,name:"bezrect0",x:170,y:140,width:50,height:50,rotation:45,strokeColor:orange,radius:4,fillColor:green,animator0:{value:"rotation",amount:5,min:0,max:360,type:BOUNCE}},
//	childBlock5: {type:CIRCLE,name:"bezcircl0",x:270,y:40,strokeColor:orange,radius:40,fillColor:green,animator0:{value:"x",amount:12,min:70,max:100,type:BOUNCE},childBlock0: {type:CIRCLE,name:"bezcircl0s",x:20,y:20,rotation:45,strokeColor:red,radius:20,fillColor:blue}},
}
addBlock(bezblock)
