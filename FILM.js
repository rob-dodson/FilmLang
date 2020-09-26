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
let red	      = {red:1.0, green:0.0, blue:0.0, alpha:1.0}
let blue      = {red:0.0, green:0.0, blue:0.9, alpha:1.0}
let green     = {red:0.0, green:0.9, blue:0.0, alpha:1.0}
let darkgreen = {red:0.0, green:0.5, blue:0.0, alpha:0.4}
let gray      = {red:0.7, green:0.7, blue:0.7, alpha:1.0}

//
// gradients
//
let grad1     = {startColor: {red:0.0, green:0.8, blue:0.0, alpha:0.6}, endColor: darkgreen }



//
// rect loop
//
for (i = 1; i < 10 ; i++)
{
	let rectname = "rect".concat(i.toString())
	let rect1 = 
	{ 
		type:RECT, 
		name:rectname, 
		x:60 * i, 
		y:150,
		width:50, 
		height:50, 
		strokeWidth:2,
		fillColor:darkgreen,
		radius:4,
		strokeColor:green,
		rotation:10,
		animator0:{value:ROTATION,amount:1.0,min:0.0,max:360,type:BOUNCE},
		animator1:{value:X,amount:1.0,min:0.0,max:300,type:BOUNCE},
		animator2:{value:Y,amount:1.0,min:150,max:169,type:INC},
	}
	addBlock(rect1)

	let textname = "text".concat(i.toString())
	let text1 = 
	{
		type:TEXT,
		name:textname,
		size:15,
		x: 15,
		y: 20,
		text:"Ok",
		textColor:green,
		parent:rectname
	}
	addBlock(text1)

}

let rectname = "rectA"
let rect1 = 
{ 
	type:RECT, 
	name:rectname, 
	x:60 * 10, 
	y:150,
	width:50, 
	height:50, 
	radius:1,
	strokeWidth:1,
	fillColor:gray,
	radius:4,
	strokeColor:green,
}
addBlock(rect1)

let textname = "textA"
let text1 = 
{
	type:TEXT,
	name:textname,
	size:15,
	x: 25,
	y: 20,
	text:"Alert",
	textColor:red,
	radius:4,
	parent:rectname,
}
addBlock(text1)


//
// grid
//
for (i = 0;i <= 2; i++)
{
	let	name = "Grid - ".concat(i.toString())
	let grid =
	{
		type:GRID,
		name:name,
		x: 50 ,
		y: 290 + (i * 105),
		width:400,
		height:100,
		fillGradient:grad1,
		gridColor:gray,
		yspacing:20,
		xspacing:20,
		radius:4,
		debug:true,
		clip:true,
		strokeColor:red,
		animator0:{value:STROKEALPHA,amount:0.1,min:0,max:.9,type:BOUNCE},
	}
	addBlock(grid)

	//
	// image
	//
	let image =
	{
		type:IMAGE,
		name:"Image1",
		url:"https://frogradio.net/images/icon_128x128.png",
		x: 40,
		y: 20,
		width:100,
		height:100,
		rotation:10,
		parent:name
	}
	addBlock(image)

}

let arc = 
{
	type:ARC,
	name:"ARC1",
	x: 700,
	y: 400,
	radius:60,
	strokeWidth:10,
	startAngle:10,
	endAngle:90,
	strokeColor:green,
	animator0:{value:STARTANGLE,amount:1,min:10,max:30,type:INC},
	animator1:{value:ENDANGLE,amount:1,min:90,max:110,type:INC},
	animator3:{value:STROKEWIDTH,amount:1,min:1,max:10,type:BOUNCE},
}
addBlock(arc)

let arc2 = 
{
	type:ARC,
	name:"ARC2",
	x: 700,
	y: 400,
	radius:80,
	strokeWidth:10,
	startAngle:10,
	endAngle:90,
	strokeColor:red,
	animator0:{value:STARTANGLE,amount:.1,min:10,max:90,type:DEC},
	animator1:{value:ENDANGLE,amount:.1,min:20,max:100,type:DEC},
	//animator4:{value:STROKEALPHA,amount:.1,min:.1,max:1.0,type:BOUNCE},
}
addBlock(arc2)

let circle = 
{
	type:CIRCLE,
	debug:true,
	name:"Circle",
	x: 700,
	y: 400,
	radius:105,
	fillGradient:{startColor: green, endColor: darkgreen } ,
}
addBlock(circle)

let circle2 = 
{
	type:CIRCLE,
	name:"Circle2",
	x: 700,
	y: 400,
	radius:110,
	strokeWidth:2,
	windowOffset:"450,450",
	strokeColor:gray,
	fillGradient:{startColor: red, endColor: darkgreen } ,
}
addBlock(circle2)


let line1 = 
{
	type:LINE,
	name:"Line1",
	x: 10,
	y: 80,
	endX: 1000,
	endY: 80,
	strokeWidth:5,
	strokeColor:red,
	windowOffset:"50,50",
}
addBlock(line1)


let rect33 = 
{
	type:RECT,
	name:"RECT33",
	x: 10,
	y: 80,
	width: 200,
	height: 200,
	strokeColor:red,
	fillGradient:{startColor: green, endColor: darkgreen } ,
	animator0:{value:X,amount:1.0,min:10,max:12,type:BOUNCE},
	animator3:{value:STROKEWIDTH,amount:1.0,min:1,max:5,type:BOUNCE},
	animator4:{value:STROKEALPHA,amount:0.1,min:.1,max:1.0,type:BOUNCE},
}
addBlock(rect33)

let path1 = 
{
	type:PATH,
	name:"Path1",
	x: 40,
	y: 40,
	strokeWidth:1,
	strokeColor:blue,
	point1:"40,140",
	point2:"45,143",
	point2:"65,120",
	parent:"RECT33",
	animator0:{value:X,amount:1,min:40,max:100,type:BOUNCE},
	animator0:{value:STROKEWIDTH,amount:1,min:1,max:4,type:BOUNCE},
}
addBlock(path1)
