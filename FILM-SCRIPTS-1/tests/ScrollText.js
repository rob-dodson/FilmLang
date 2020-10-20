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
let cyansolid = { red: 0.07, green: 0.61, blue: 0.65, alpha: 1.0}
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
    startColor: {red:0.0, green:0.5, blue:0., alpha:0.4},
    endColor: {red:0.0, green:0.0, blue:0.0, alpha:0.1},
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
	clip:true,
	fitToView:true,
	fillGradient: { startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6},endColor: {red:0.0, green:0.0, blue:0.0, alpha:0.4}},
}
addBlock(screen)

let layout = 
{
    type:LAYOUT,
    name:"layout",
    xcount:4,
    ycount:4,
    debug:false,
}
addBlock(layout)

for (x = 0; x < 4; x++)
{
	for (y = 0; y < 4; y++)
	{
		let	name = "back".concat(x.toString()).concat(y.toString())

		let back = 
		{
			name:name,
			width:400,
			height:250,
			type:RECT,
			fillColor:cyan,
			strokeColor:orange,
			strokeWidth:2,
			layoutSpec:{x:x,y:y,fit:false},
		}
		addBlock(back)

		let scrollblock1 =
		{
			name:"scrollblock1",
			type:SCROLLTEXT,
			width:400,
			height:250,
			radius:4,
			clip:true,
			textURL:"/Users/robertdodson/Desktop/FILM/scrollingtext.txt",
			size:14,
			font:MainFont,
			strokeColor:cyan,
			strokeWidth:2,
			textColor:green,
			animator0:{value:"scrollamount",amount:2*x,min:0,max:-3000.0,type:INC},
			parent:name
		}
		addBlock(scrollblock1)
	}
}

