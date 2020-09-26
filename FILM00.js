//
// FilmLang 1.0 - test
//


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
let red	      = {red:1.0, green:0.0, blue:0.0, alpha:0.8}
let blue      = {red:0.0, green:0.0, blue:0.9, alpha:0.8}
let green     = {red:0.0, green:0.9, blue:0.0, alpha:0.8}
let darkgreen = {red:0.0, green:0.5, blue:0.0, alpha:0.4}
let gray      = {red:0.7, green:0.7, blue:0.7, alpha:0.6}

let camborder      = {red:0.5, green:0.5, blue:0.5, alpha:0.7}
let camback	  = {red:0.0, green:0.0, blue:0.4, alpha:0.6}
let camiconcolor = {red:0.0, green:0.0, blue:0.4, alpha:0.6}

//
// gradients
//
let blockbackgrad = 
{
	startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6}, 
	endColor: {red:0.0, green:0.3, blue:0.3, alpha:0.4},
}


let CamBlock = 
{
	name:"CamBlock",
	type:RECT,
	x:40,
	y:420,
	width:340,
	height:330,
	fillGradient:blockbackgrad,
	gradientAngle:-50,
	childBlock0: {type:TEXT,name:"title",text:"CAMERAS",size:20,x:340/2,y:290,textColor:gray,font:"Futura" },
}
addBlock(CamBlock)

for (x = 0; x <= 4; x++)
{
	for (y = 0; y <= 5; y++)
	{
		let camname = "Cam".concat(x.toString()).concat(y.toString())
		let camnum = x.toString().concat(y.toString())

		let bordercolor = camborder
		if ((x == 2 && y == 1) || (x == 1 && y == 4))
			bordercolor = red

		let Cam = 
		{
			name:camname,
			type:RECT,
			x:10 + (x * 65),
			y:10 + (y * 50),
			width:60,
			height:40,
			strokeColor:bordercolor,
			fillColor:camback,
			childBlock0: {type:RECT,name:"icon", x:5,y:20,width:30,height:15,fillColor:camiconcolor },
			childBlock1: {type:TEXT,name:"text",text:camname,size:10,x:20,y:-5,textColor:darkgreen },
			childBlock2: {type:TEXT,name:"textbig",text:camnum,size:15,x:48,y:10,textColor:gray,font:"Futura" },
			parent:"CamBlock",
		}
		addBlock(Cam)
	}
}



