//
// BezBlock
//
let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:20,
	y:20,
	layoutSpec:{x:3,y:2,fit:true},
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	strokeColor:orange,
	strokeWidth:5,
	radius:4,
//	animator0:{value:"x",amount:1,min:20,max:20,type:BOUNCE},
	childBlock0: {type:TEXT,name:"beztitle",text:"BEZ-1",size:20,x:10,y:360,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
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
	strokeColor:orange,
	fillColor:cyan,
	point0:{x: 250, y: 32},
	point1:{x: 260, y: 34},
	point2:{x: 260, y: 80},
	point3:{x: 250, y: 82},
	point4:{x: 250, y: 32},
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
let line1 = { type:LINE,name:"line1",x:250,y:200,endX:330,endY:200,strokeWidth:10,strokeColor:cyan,parent:"bezblock",z:-1}
addBlock(line1)
let line2 = { type:LINE,name:"line2",x:250,y:200,endX:290,endY:270,strokeWidth:10,strokeColor:red,parent:"bezblock",z:-1}
addBlock(line2)
let line3 = { type:LINE,name:"line3",x:330,y:200,endX:290,endY:270,strokeWidth:10,strokeColor:cyan,parent:"bezblock",z:-1}
addBlock(line3)

let rad = 25
for (i = 0; i < 3; i++)
{
	let circle1 = {type:CIRCLE,name:"circle1",x:250,y:200,radius:rad,strokeColor:cyan,parent:"bezblock"}
	addBlock(circle1)
	rad = rad - 3
}
let dot1 = {type:CIRCLE,debug:false,name:"dot1",x:250,y:200,radius:15,strokeColor:cyan,fillColor:cyansolid,parent:"bezblock"}
addBlock(dot1)
let arc1 = {type:CIRCLE,name:"arc1",strokeStart:.1,strokeEnd:.9,x:250,y:200,radius:8,strokeWidth:5,strokeColor:blue,parent:"bezblock",
	animation0:{property:"strokeStart",from:.1,to:.5,duration:2.4,autoReverses:true},
	animation1:{property:"strokeEnd",from:.3,to:.8,duration:2.4,autoReverses:true},}
addBlock(arc1)
let text1 = {type:TEXT,name:"text1",x:0,y:-25,text:"/// 432",textColor:cyan,size:10,parent:"dot1"}
addBlock(text1)


rad = 25
for (i = 0; i < 3; i++)
{
	let circle1 = {type:CIRCLE,name:"circle1",x:330,y:200,radius:rad,strokeColor:cyan,parent:"bezblock"}
	addBlock(circle1)
	rad = rad - 3
}
let dot2 = {type:CIRCLE,debug:false,name:"dot2",x:330,y:200,radius:15,strokeColor:cyan,fillColor:cyansolid,parent:"bezblock"}
addBlock(dot2)
let arc2 = {type:CIRCLE,name:"arc2",strokeStart:.4,strokeEnd:.8,x:330,y:200,radius:8,strokeWidth:5,strokeColor:red,parent:"bezblock",
	animation0:{property:"strokeStart",from:.1,to:.5,duration:2.4,autoReverses:true},
	animation1:{property:"strokeEnd",from:.3,to:.8,duration:2.4,autoReverses:true},}
addBlock(arc2)
let text2 = {type:TEXT,name:"text2",x:0,y:-25,text:"/// 673",textColor:cyan,size:10,parent:"dot2"}
addBlock(text2)

rad = 25
for (i = 0; i < 3; i++)
{
	let circle1 = {type:CIRCLE,name:"circle1",x:290,y:270,radius:rad,strokeColor:cyan,parent:"bezblock"}
	addBlock(circle1)
	rad = rad - 3
}
let dot3 = {type:CIRCLE,debug:false,name:"dot3",x:290,y:270,radius:15,strokeColor:cyan,fillColor:cyansolid,parent:"bezblock"}
addBlock(dot3)
let arc3 = {
	type:CIRCLE,name:"arc3",x:290,y:270,strokeStart:.8,strokeEnd:1.0,radius:8,strokeWidth:5,strokeColor:orange,parent:"bezblock",
	animation0:{property:"strokeStart",from:.1,to:.5,duration:2.4,autoReverses:true},
	animation1:{property:"strokeEnd",from:.3,to:.8,duration:2.4,autoReverses:true},
}
addBlock(arc3)
let text3 = {type:TEXT,name:"text3",x:0,y:45,text:"/// 129",textColor:cyan,size:10,parent:"dot3"}
addBlock(text3)

