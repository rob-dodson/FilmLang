//
// constants
//
let RECT = "Rect"
let TEXT = "Text"
let GRID = "Grid"
let green = ".0,.9,.0,0.9"
let darkgreen = ".0,.5,.0,0.9"
let red = ".9,.9,.0,1.0"


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
	let grid =
	{
		type:GRID,
		name:"Grid1",
		x: 50 ,
		y: 290 + (i * 105),
		width:400,
		height:100,
		fillColor:darkgreen,
		gridColor:".0,.0,.9,0.9",
		yspacing:20,
		xspacing:20,
		radius:4
	}
	addBlock(grid)
}

