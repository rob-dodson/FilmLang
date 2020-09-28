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
let blue      = { red:0.0, green:0.0, blue:0.9, alpha:0.8}
let green     = { red:0.0, green:0.9, blue:0.0, alpha:0.8}
let darkgreen = { red:0.0, green:0.5, blue:0.0, alpha:0.4}
let gray      = { red:0.7, green:0.7, blue:0.7, alpha:0.6}
let orange    = { red: 0.76, green: 0.38, blue: 0.05, alpha: 1.00 }
let black     = { red: 0.0, green: 0.0, blue: 0.0, alpha: 1.00 }

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
//
// Cam Block
//

let CamBlock = 
{
	name:"CamBlock",
	type:RECT,
	x:60,
	y:420,
	width:340,
	height:330,
	radius:4,
	fillGradient:blockbackgrad,
	gradientAngle:-50,
	childBlock0: {type:TEXT,name:"title",text:"cameras",size:20,x:130,y:305,textColor:gray,font:MainFont },
}
addBlock(CamBlock)

for (x = 0; x <= 4; x++)
{
	for (y = 0; y <= 5; y++)
	{
		let camname = "Cam".concat(x.toString()).concat(y.toString())
		let camnum = x.toString().concat(y.toString())

		let bordercolor = camborder
		let iconcolor = camiconcolor
		if ((x == 2 && y == 1) || (x == 1 && y == 4))
		{
			bordercolor = red
			iconcolor = red
		}

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
			childBlock0: {type:RECT,name:"icon", x:5,y:20,width:30,height:15,fillColor:iconcolor },
			childBlock1: {type:TEXT,name:"text",text:camname,size:10,x:5,y:5,textColor:darkgreen },
			childBlock2: {type:TEXT,name:"textbig",text:camnum,size:15,x:40,y:20,textColor:gray,font:MainFont },
			parent:"CamBlock",
		}
		addBlock(Cam)
	}
}

let label1 = { type:TEXT,name:"label1",text:"723778-8293*9",    rotation:45,size:10,x:20,y:550,textColor:orange,font:MainFont }
let label2 = { type:TEXT,name:"label2",text:"xxc - 903939",     rotation:45,size:0,x:20,y:350,textColor:orange,font:MainFont }
let label3 = { type:TEXT,name:"label2",text:"spec-9023 ** 324A",rotation:45,size:10,x:20,y:150,textColor:orange,font:MainFont }
addBlock(label1)
addBlock(label2)
addBlock(label3)


//x:40,
//	y:420,
//	width:340,
//	height:330,
let cambracket = 
{
	name:"cambracket",
	type:PATH,
	x: 80,
    y: 410,
    strokeWidth:10,
    point1:{x:50,y:410},
    point2:{x:50,y:760},
    point3:{x:80,y:760},
	strokeColor:blue,
}
addBlock(cambracket)

let titleblock =
{
	name:"titleblock",
	type:RECT,
	x:500,
	y:750,
	width:200,
	height:100,
	fillGradient:blockbackgrad,
	radius:4,
	childBlock0: {type:TEXT,name:"title",text:"central core",size:20,x:10,y:40,textColor:gray,font:MainFont },
	childBlock1: {type:TEXT,name:"sub1",text:"IG. US",size:15,x:10,y:10,textColor:black,font:MainFont },
}
addBlock(titleblock)

let testbez =
{
	name:"testbez",
	type:BEZIER,
	x:500,
	y:750,
	strokeWidth:5,
    point0:{x: 29.5, y: 73.5},
    point1:{point:{x: 58.5, y: 57.5},controlpoint1:{x: 29.5, y: 73.5},controlpoint2:{x: 42.5, y: 57.5}},
    point2:{point:{x: 90.5, y: 73.5},controlpoint1:{x: 74.5, y: 57.5},controlpoint2:{x: 90.5, y: 73.5}},
    strokeColor:blue,
}
addBlock(testbez)

