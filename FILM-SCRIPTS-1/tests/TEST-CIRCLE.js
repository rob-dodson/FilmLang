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

let XX = 15 
let YY = 15 
let layout =
{
    type:LAYOUT,
    name:"layout",
    xcount:XX,
    ycount:YY,
    debug:false,
}
addBlock(layout)


let dur = 2.25
let rev = true


for (x = 1; x <= XX; x++)
{
	for (y = 1; y <= YY; y++)
	{
		let name = "circle".concat(x.toString()).concat(y.toString())
		let circle =
		{
			name:name,
			type:CIRCLE,
			debug:false,
			radius:15,
			x:0,
			y:0,
			center:true,
			layoutSpec:{x:x - 1,y:y - 1,fit:true},
			strokeColor:orange,
			fillColor:blue,
			strokeWidth:2,
			childBlock0: {type:TEXT,name:"title",text:name,size:15,x:10,y:40,textColor:red,font:MainFont },
			lineCap:"round",
			animation0:{property:"strokeStart",from:.0,to:.5,duration:dur,autoReverses:rev},
            animation1:{property:"strokeEnd",from:.5,to:1.0,duration:dur,autoReverses:rev},
			//animation2:{property:"radius",from:10,to:150,duration:dur,autoReverses:rev},
			//animation3:{property:"position",move:{x:-75,y:-75},duration:dur,autoReverses:rev},
			//animation4:{property:"opacity",from:.3,to:1,duration:dur,autoReverses:rev},
			animation5:{property:"lineWidth",from:1,to:15,duration:.5,autoReverses:rev},
			animation6:{property:"strokeColor",fromColor:blue,toColor:red,duration:dur,autoReverses:rev},
			animation7:{property:"transform.rotation.z",from:0,to:6,duration:dur,autoReverses:rev},
			animation8:{property:"transform.rotation.x",from:0,to:6,duration:dur,autoReverses:rev},
		}
		addBlock(circle)
	}
}
