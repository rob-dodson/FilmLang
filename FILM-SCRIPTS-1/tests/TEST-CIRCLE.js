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
	fillGradient: { startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6},endColor: {red:0.0, green:0.0, blue:0.0, alpha:0.4}},
}
addBlock(screen)

let dur = 1.25
let rev = true

for (x = 1; x < 10; x++)
{
	for (y = 1; y < 5; y++)
	{
		let circle =
		{
			name:"circle",
			type:CIRCLE,
			x:200 * x,
			y:200 * y,
			radius:50,
			strokeColor:orange,
			strokeWidth:5,
			animation0:{property:"strokeStart",from:.1,to:.5,duration:dur,autoReverses:rev},
			animation1:{property:"strokeEnd",from:.6,to:.7,duration:2.4,autoReverses:rev},
			//animation2:{property:"radius",from:10,to:150,duration:dur,autoReverses:rev},
			//animation1:{property:"position",move:{x:-140,y:-140},duration:dur,autoReverses:rev},
			animation3:{property:"opacity",from:.3,to:1,duration:dur,autoReverses:rev},
			animation4:{property:"lineWidth",from:5,to:22,duration:dur,autoReverses:rev},
			animation5:{property:"strokeColor",fromColor:blue,toColor:red,duration:dur,autoReverses:rev},
			//animation6:{property:"transform.rotation.z",from:0,to:6,duration:dur,autoReverses:rev},
			//animation7:{property:"transform.rotation.x",from:0,to:6,duration:dur,autoReverses:rev},
		}
		addBlock(circle)
	}
}
