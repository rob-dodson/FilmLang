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

let green = ".0,.9,.0,0.9"
let darkgreen = ".0,.5,.0,0.9"
let red = ".9,.0,.0,1.0"


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
		fillColor:".5,.5,.5,0.5", 
		radius:4,
		strokeColor:green,
		rotation:10,
		animator0:"rotation,1.0,0.0,360,Bounce",
		animator1:"x,1.0,0.0,300,Bounce",
		animator2:"y,1.0,150,160,Inc",
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
	fillColor:".5,.5,.5,0.5", 
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
		fillColor:darkgreen,
		gridColor:".0,.0,.9,0.9",
		yspacing:20,
		xspacing:20,
		radius:4,
		debug:true,
		clip:true,
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
	name:"ARC",
	x: 700,
	y: 400,
	radius:60,
	strokeWidth:10,
	startAngle:10,
	endAngle:90,
	strokeColor:".8,.0,.8,.9",
	animator0:"startangle,1,10,30,Inc",
	animator1:"endangle,1,90,110,Inc",
	animator3:"strokewidth,1,1,10,Bounce",
}
addBlock(arc)

let arc2 = 
{
	type:ARC,
	name:"ARC",
	x: 700,
	y: 400,
	radius:80,
	strokeWidth:10,
	startAngle:10,
	endAngle:90,
	strokeColor:".0,.0,.8,.9",
	animator0:"startangle,.1,10,90,Dec",
	animator1:"endangle,.1,20,100,Dec",
}
addBlock(arc2)

let circle = 
{
	type:CIRCLE,
	name:"Circle",
	x: 700,
	y: 400,
	radius:105,
	fillColor:".8,.8,.8,.4",
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
	strokeColor:".9,.9,.9,1.0",
}
addBlock(circle2)


let line1 = 
{
	type:LINE,
	name:"Line1",
	x: 10,
	y: 50,
	endX: 1000,
	endY: 50,
	strokeWidth:2,
	strokeColor:green,
}
addBlock(line1)
