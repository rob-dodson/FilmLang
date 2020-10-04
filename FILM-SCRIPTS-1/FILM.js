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
let orange    = { red: 0.76, green: 0.38, blue: 0.05, alpha: 1.00 }
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

let layout = 
{
    type:LAYOUT,
    name:"layout",
    xcount:4,
    ycount:4,
    debug:false,
}
addBlock(layout)

let axis =
{
    name:"axis",
    type:AXIS,
	axisColor: { red: 0.76, green: 0.38, blue: 0.00, alpha: 1.00 },
    x:30,
    y:30,
    width:400,
    height:300,
    layoutSpec:{x:3,y:2,fit:false},
    strokeWidth:2,
    strokeColor:cyan,
	point0:{x: 0, y: 0},
    point1:{x: 27, y: 44},
    point2:{x: 37, y: 92},
    point3:{x: 56, y: 94},
    point4:{x: 86, y: 42},
}
addBlock(axis)
//
// BezBlock
//
let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:20,
	y:20,
	layoutSpec:{x:3,y:3,fit:false},
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	radius:4,
	childBlock0: {type:TEXT,name:"beztitle",text:"BEZ-1",size:20,x:30,y:360,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
}
addBlock(bezblock)

for (i = 0; i < 3; i++)
{
	let yoffset = 18 

	if (i == 0)
	{
		let text =  {type:TEXT,name:"dtx",text:"DTX".concat(i.toString()),size:15,x:222,y:42 + (i * yoffset),
		textColor:gray,fillColor:cyan,font:MainFont,textColor:gray,parent:"bezblock" }
		addBlock(text)
	}
	else
	{
	let text =  {type:TEXT,name:"dtx",text:"DTX".concat(i.toString()),size:15,x:222,y:42 + (i * yoffset),
		textColor:gray,font:MainFont,textColor:gray,parent:"bezblock" }
	addBlock(text)
	}
}

let dtxblock = 
{ 
	type:PATH,
	name:"dtxblock",
	fillColor:cyan,
	point0:{x: 260, y: 42},
	point1:{x: 270, y: 44},
	point2:{x: 270, y: 90},
	point3:{x: 260, y: 92},
	point4:{x: 260, y: 42},
	parent:"bezblock"
}
addBlock(dtxblock)

for (i = 0; i < 5; i++)
{
	let yoffset = 20

	let text =  {type:TEXT,name:"tab",text:"TAB-".concat(i.toString()),size:15,x:20,y:40 + (i * yoffset),
		textColor:gray,font:MainFont,textColor:gray,parent:"bezblock" }
	addBlock(text)

	if (i == 0)
	{
	let text2 =  {type:TEXT,name:"tab",text:"CAT-".concat(i.toString()),size:15,x:20,y:240 + (i * yoffset),
		textColor:gray,fillColor:cyan,font:MainFont,textColor:gray,parent:"bezblock" }
	addBlock(text2)
	}
	else
	{
	let text2 =  {type:TEXT,name:"tab",text:"CAT-".concat(i.toString()),size:15,x:20,y:240 + (i * yoffset),
		textColor:gray,font:MainFont,textColor:gray,parent:"bezblock" }
	addBlock(text2)
	}

	let testbez =
	{
		name:"testbez",
		type:BEZIER,
		x:10,
		y:45 + (i * yoffset),
		strokeWidth:3,
		point1:{ x: 60, y: 200 },
		point2:{ point:{ x: 90, y: 100 }, controlpoint1:{ x: 60, y:200 }, controlpoint2:{ x: 90, y:170 }},
		point3:{ point:{ x: 60, y: 0  },  controlpoint1:{ x: 90, y:30  }, controlpoint2:{ x: 60, y:0 }},
		strokeColor:cyan,
		parent:"bezblock"
	}
	addBlock(testbez)
}


let bigbez =
{
	name:"bigbez",
	type:BEZIER,
	x:27,
	y:50,
	strokeWidth:10,
	debug:false,
	point1:{ x: 45,  y: 200 },
	point2:{ point:{ x: 100,  y: 190 }, controlpoint1:{ x: 45, y: 200  }, controlpoint2:{ x: 80, y: 220 }},
	point3:{ point:{ x: 145, y: 15  }, controlpoint1:{ x: 120, y: 180 }, controlpoint2:{ x: 135,  y: 20 }},
	point4:{ point:{ x: 190, y: 0   }, controlpoint1:{ x: 155, y: -10 }, controlpoint2:{ x: 190, y: 0 }},
	strokeColor:cyan,
	parent:"bezblock"
}
addBlock(bigbez)


//
// circles
// 
let line1 = { type:LINE,name:"line1",x:250,y:200,endX:330,endY:200,strokeWidth:10,strokeColor:cyan,parent:"bezblock"}
addBlock(line1)
let line2 = { type:LINE,name:"line2",x:250,y:200,endX:290,endY:270,strokeWidth:10,strokeColor:cyan,parent:"bezblock"}
addBlock(line2)
let line3 = { type:LINE,name:"line3",x:330,y:200,endX:290,endY:270,strokeWidth:10,strokeColor:cyan,parent:"bezblock"}
addBlock(line3)

let rad = 25
for (i = 0; i < 3; i++)
{
	let circle1 = {type:CIRCLE,name:"circle1",x:250,y:200,radius:rad,strokeColor:cyan,parent:"bezblock"}
	addBlock(circle1)
	rad = rad - 3
}
let dot1 = {type:CIRCLE,debug:false,name:"dot1",x:250,y:200,radius:15,strokeColor:cyan,fillColor:orange,parent:"bezblock"}
addBlock(dot1)
let arc1 = {type:ARC,name:"arc1",startAngle:10,endAngle:90,x:250,y:200,radius:10,strokeWidth:5,strokeColor:blue,parent:"bezblock"}
addBlock(arc1)
let text1 = {type:TEXT,name:"text1",x:0,y:-38,text:"/// 432",textColor:cyan,size:10,parent:"dot1"}
addBlock(text1)


rad = 25
for (i = 0; i < 3; i++)
{
	let circle1 = {type:CIRCLE,name:"circle1",x:330,y:200,radius:rad,strokeColor:cyan,parent:"bezblock"}
	addBlock(circle1)
	rad = rad - 3
}
let dot2 = {type:CIRCLE,debug:false,name:"dot2",x:330,y:200,radius:15,strokeColor:cyan,fillColor:orange,parent:"bezblock"}
addBlock(dot2)
let arc2 = {type:ARC,name:"arc2",startAngle:20,endAngle:190,x:330,y:200,radius:10,strokeWidth:5,strokeColor:red,parent:"bezblock"}
addBlock(arc2)
let text2 = {type:TEXT,name:"text2",x:0,y:-38,text:"/// 673",textColor:cyan,size:10,parent:"dot2"}
addBlock(text2)

rad = 25
for (i = 0; i < 3; i++)
{
	let circle1 = {type:CIRCLE,name:"circle1",x:290,y:270,radius:rad,strokeColor:cyan,parent:"bezblock"}
	addBlock(circle1)
	rad = rad - 3
}
let dot3 = {type:CIRCLE,debug:false,name:"dot3",x:290,y:270,radius:15,strokeColor:cyan,fillColor:orange,parent:"bezblock"}
addBlock(dot3)
let arc3 = {type:ARC,name:"arc3",startAngle:20,endAngle:290,x:290,y:270,radius:10,strokeWidth:5,strokeColor:blue,parent:"bezblock"}
addBlock(arc3)
let text3 = {type:TEXT,name:"text3",x:0,y:26,text:"/// 129",textColor:cyan,size:10,parent:"dot3"}
addBlock(text3)


//
// Cam Block
//

let CamBlock = 
{
	name:"CamBlock",
	type:RECT,
	x:40,
	y:20,
	layoutSpec:{x:1,y:3,fit:true},
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

let label1 = { type:TEXT,name:"label1",text:"723778-8293*9",    layoutSpec:{x:1,y:1,fit:false},rotation:45,size:10,x:10,y:50,textColor:orange,font:MainFont }
let label2 = { type:TEXT,name:"label2",text:"xxc - 903939",     layoutSpec:{x:1,y:2,fit:false},rotation:45,size:10,x:10,y:50,textColor:orange,font:MainFont }
let label3 = { type:TEXT,name:"label2",text:"spec-9023 ** 324A",layoutSpec:{x:1,y:3,fit:false},rotation:45,size:10,x:10,y:50,textColor:orange,font:MainFont }
addBlock(label1)
addBlock(label2)
addBlock(label3)


//
// bracket
//
let cambracket = 
{
	name:"cambracket",
	type:PATH,
	x: 20,
    y: -10,
    strokeWidth:10,
    point1:{x:-10,y:-10},
    point2:{x:-10,y:340},
    point3:{x:20,y:340},
	strokeColor:cyan,
	parent:"CamBlock",
}
addBlock(cambracket)

let titleblock =
{
	name:"titleblock",
	type:RECT,
	layoutSpec:{x:2,y:4,fit:false},
	x:50,
	y:100,
	width:200,
	height:100,
	fillGradient:blockbackgrad,
	radius:4,
	childBlock0: {type:TEXT,name:"title",text:"central core",size:20,x:10,y:40,textColor:gray,font:MainFont },
	childBlock1: {type:TEXT,name:"sub1",text:"IG. US",size:15,x:10,y:10,textColor:black,font:MainFont },
}
addBlock(titleblock)


