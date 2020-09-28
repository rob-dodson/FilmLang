//
// BezBlock
//
let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:850,
	y:450,
	width:400,
	height:300,
	fillGradient:blockbackgrad,
	radius:4,
	childBlock0: {type:TEXT,name:"beztitle",text:"BEZ-1",size:20,x:30,y:290,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
}
addBlock(bezblock)

for (i = 0; i < 3; i++)
{
	let yoffset = 14 

	let text =  {type:TEXT,name:"dtx",text:"DTX".concat(i.toString()),size:15,x:222,y:42 + (i * yoffset),
		textColor:gray,font:MainFont,textColor:gray,parent:"bezblock" }

	addBlock(text)
}

let dtxblock = 
{ 
	type:PATH,
	name:"dtxblock",
	fillColor:gray,
	point0:{x: 260, y: 42},
	point1:{x: 270, y: 44},
	point2:{x: 270, y: 82},
	point3:{x: 260, y: 84},
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

	let testbez =
	{
		name:"testbez",
		type:BEZIER,
		x:10,
		y:15 + (i * yoffset),
		strokeWidth:3,
		point0:{x: 57.5, y: 110.5},
		point1:{point:{x: 71.5, y: 110.5}, controlpoint1:{x: 57.5, y: 110.5}, controlpoint2:{x: 67.5, y: 110.5}},
		point2:{point:{x: 71.5, y: 41.5}, controlpoint1:{x: 75.5, y: 69.5}, controlpoint2:{x: 74.5, y: 49.5}},
		point3:{point:{x: 59.9, y: 30.5}, controlpoint1:{x: 68.5, y: 33.5}, controlpoint2:{x: 59.9, y:31.5}},
		strokeColor:gray,
		parent:"bezblock"
	}

	addBlock(testbez)
}
