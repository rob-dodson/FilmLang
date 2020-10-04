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
	x: 20,
    y: -10,
    strokeWidth:10,
    point1:{x:-10,y:-10},
    point2:{x:-10,y:340},
    point3:{x:20,y:340},
	strokeColor:blue,
	parent:"CamBlock",
}
addBlock(cambracket)
