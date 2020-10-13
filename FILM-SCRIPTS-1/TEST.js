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
	x:20,
	y:20,
	width:300,
	height:400,
	gradientAngle:-50,
	strokeColor:orange,
	clip:true,
	fitToView:true,
	fillGradient: { startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6},endColor: {red:0.0, green:0.0, blue:0.0, alpha:0.4}},
}
addBlock(screen)


let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:20,
	y:20,
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	strokeColor:orange,
	strokeWidth:5,
	radius:4,
//	animator0:{value:"x",amount:10,min:0,max:500,type:BOUNCE},
	childBlock0: {type:TEXT,name:"beztitle",text:"BEZ-1",size:64,x:40,y:20,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,padding:5},
	childBlock1: {type:TEXT,name:"beztitle",text:"BEZ-1",size:42,x:40,y:120,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,fillColor:red,padding:5},
	childBlock2: {type:TEXT,name:"beztitle",text:"primary BEZ-1",size:22,x:40,y:220,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5},
}
addBlock(bezblock)

