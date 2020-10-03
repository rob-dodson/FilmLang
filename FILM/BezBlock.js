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
	fillColor:gray,
	point0:{x: 260, y: 42},
	point1:{x: 270, y: 44},
	point2:{x: 270, y: 92},
	point3:{x: 260, y: 94},
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

	debug:true,
	point1:{ x: 45,  y: 200 },
	point2:{ point:{ x: 100,  y: 190 }, controlpoint1:{ x: 45, y: 200  }, controlpoint2:{ x: 80, y: 220 }},
	point3:{ point:{ x: 145, y: 15  }, controlpoint1:{ x: 120, y: 180 }, controlpoint2:{ x: 135,  y: 20 }},
	point4:{ point:{ x: 190, y: 0   }, controlpoint1:{ x: 155, y: -10 }, controlpoint2:{ x: 190, y: 0 }},

	strokeColor:cyan,
	parent:"bezblock"
}
addBlock(bigbez)


