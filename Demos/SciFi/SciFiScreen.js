includeFile("Constants")

let camborder = {red:0.5, green:0.5, blue:0.5, alpha:0.7}
let camback   = {red:0.0, green:0.0, blue:0.4, alpha:0.6}
let camiconcolor = {red:0.09, green:0.09, blue:0.8, alpha:0.7}
let radius = 4


let screen = 
{
	type:RECT,
	name:"Screen",
	x:20,
	y:20,
	width:300,
	height:400,
	gradientAngle:0.0,
	scale:0.75,
	clip:true,
	fitToView:true,
	fillGradient: { startColor: {red:0.0, green:0.5, blue:0.5, alpha:0.6},endColor: {red:0.0, green:0.0, blue:0.0, alpha:0.4}},
}
addBlock(screen)

let layout = 
{
    type:LAYOUT,
    name:"layout",
    xcount:4,
    ycount:4,
    debug:false,
	debugColor:gray,
}
addBlock(layout)

let width = 350
let height = 250


let toptitle = 
{
	type:TEXT,name:"top",text:"MT56r7 - MANAGEMENT PANEL - Version: 23.5.61.7.22",padding:5,size:50,x:20,y:1000,textColor:cyan,font:MainFont 
}
addBlock(toptitle)


let scene =
{
	type:SCENEVIEW,
	name:"sceneview",
	x:10,
	y:100,
	width:width,
	height:height,
	fillColor:{red:0.0,green:0.0,blue:0.0,alpha:0.0},
	layoutSpec:{x:2,y:2,fit:false},
	objectFilePath:"teapot.obj",
    objectScale:{x:50,y:50,z:50},
    objectPosition:{x:width/2,y:height/3,z:50},
	objectColor:{red:.5,green:.5,blue:.5,alpha:1.0},
    cameraPosition:{x:width/2,y:height/2,z:350},
    lightPosition:{x:50,y:height,z:100},
}
addBlock(scene)

//
// graph
//
let axis =
{
    name:"axis",
    type:AXIS,
	axisColor: orange,
    x:0,
    y:0,
    width:300,
    height:200,
	scale:.5,
    layoutSpec:{x:2,y:1,fit:false},
    strokeWidth:1,
    strokeColor:cyan,
	point0:{x: 0, y: 0},
    point1:{x: 10, y: 44},
    point2:{x: 20, y: 92},
    point3:{x: 30, y: 94},
    point4:{x: 40, y: 42},
	point5:{x: 50, y: 10},
	point6:{x: 100, y: 44},
	point7:{x: 110, y: 92},
	point8:{x: 120, y: 94},
	point9:{x: 130, y: 42},
	point10:{x: 140, y: 5},
	point11:{x: 150, y: 44},
	point12:{x: 160, y: 92},
	point13:{x: 170, y: 94},
	point14:{x: 180, y: 42},
	point15:{x: 190, y: 9},
	point16:{x: 200, y: 88},
	point17:{x: 210, y: 92},
	point18:{x: 220, y: 194},
	point19:{x: 230, y: 142},
	childBlock0: {type:TEXT,name:"title",text:" Average ",padding:5,size:20,x:10,y:200,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
	childBlock1: {type:TEXT,name:"label",text:"12.4%",size:20,x:10,y:10,textColor:gray,font:MainFont },
	childBlock2: {type:TEXT,name:"label",text:"*12.2*",size:20,x:100,y:90,textColor:orange,font:MainFont },
	childBlock3: {type:TEXT,name:"label",text:"-- 123+^^34",size:15,x:150,y:140,textColor:red,font:MainFont },
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
	layoutSpec:{x:3,y:2,fit:true},
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	strokeColor:blue,
	strokeWidth:2,
	radius:radius,
//	animator0:{value:"x",amount:1,min:20,max:20,type:BOUNCE},
	childBlock0: {type:TEXT,name:"beztitle",text:"BEZ-1",padding:5,size:20,x:10,y:360,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
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
	point0:{x: 262, y: 43},
	point1:{x: 272, y: 46},
	point2:{x: 272, y: 87},
	point3:{x: 262, y: 90},
	point4:{x: 262, y: 43},
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
		point2:{ point:{ x: 90, y: 100 }, controlPoint1:{ x: 60, y:200 }, controlPoint2:{ x: 90, y:170 }},
		point3:{ point:{ x: 60, y: 0  },  controlPoint1:{ x: 90, y:30  }, controlPoint2:{ x: 60, y:0 }},
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
	strokeWidth:8,
	debug:false,
	point1:{ x: 45,  y: 200 },
	point2:{ point:{ x: 100,  y: 190 }, controlPoint1:{ x: 45, y: 200  }, controlPoint2:{ x: 80, y: 220 }},
	point3:{ point:{ x: 145, y: 15  }, controlPoint1:{ x: 120, y: 180 }, controlPoint2:{ x: 135,  y: 20 }},
	point4:{ point:{ x: 190, y: 0   }, controlPoint1:{ x: 155, y: -10 }, controlPoint2:{ x: 190, y: 0 }},
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


//
// Cam Block
//

let red1       = { red:.7, green:0.0, blue:0.0, alpha:0.8}
let red2       = { red:.9, green:0.0, blue:0.0, alpha:0.8}

let CamBlock = 
{
	name:"CamBlock",
	type:RECT,
	x:60,
	y:20,
	layoutSpec:{x:0,y:2,fit:true},
	width:340,
	height:330,
	radius:radius,
	strokeWidth:5,
	strokeColor:green,
	fillGradient:blockbackgrad,
	//animation0:{property:"position",move:{x:40,y:0},duration:1.25,repeatDuration:100,autoReverses:true},
	//animation1:{property:"backgroundColor",fromColor:red,toColor:green,duration:1.25,repeatDuration:100,autoReverses:true},
	animation2:{property:"borderColor",fromColor:blue,toColor:cyan,duration:3.25,repeatDuration:100,autoReverses:true},
	//animation3:{property:"opacity",from:0,to:1,duration:.1,repeatDuration:100,autoReverses:true},
	//animation4:{property:"cornerRadius",from:1,to:12,duration:.25,repeatDuration:100,autoReverses:true},
	//animation5:{property:"borderWidth",from:1,to:12,duration:.25,repeatDuration:100,autoReverses:true},
	childBlock0: {type:TEXT,name:"title",text:"cameras",size:20,x:130,y:305,textColor:gray,font:MainFont },
}
addBlock(CamBlock)

let cameraicon =
{ 
	type:PATH,
	name:"cameraicon",
	fillColor:camiconcolor,
	point0:{x: 5, y: 20},
	point1:{x: 25, y: 20},
	point2:{x: 25, y: 24},
	point3:{x: 35, y: 20},
	point4:{x: 35, y: 30},
	point5:{x: 25, y: 26},
	point6:{x: 25, y: 30},
	point7:{x: 5, y: 30},
	point8:{x: 5, y: 20},
}

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
			
			childBlock0: cameraicon,
			childBlock1: {type:TEXT,name:"text",text:camname,size:10,x:5,y:5,textColor:darkgreen },
			childBlock2: {type:TEXT,name:"textbig",text:camnum,size:15,x:40,y:20,textColor:gray,font:MainFont },
			parent:"CamBlock",
		}
		addBlock(Cam)
	}
}

let label1 = { type:TEXT,name:"label1",text:"723778-8293*9", layoutSpec:{x:0,y:1,fit:false},rotation:90,size:15,x:-45,y:50,textColor:orange,font:MainFont }
let label2 = { type:TEXT,name:"label2",text:"723778-8293*9", layoutSpec:{x:0,y:2,fit:false},rotation:90,size:15,x:-45,y:50,textColor:orange,font:MainFont }
let label3 = { type:TEXT,name:"label3",text:"723778-8293*9", layoutSpec:{x:0,y:3,fit:false},rotation:90,size:15,x:-45,y:50,textColor:orange,font:MainFont }
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
    strokeWidth:10,
    point1:{x:30,y:-15},
    point2:{x:-15,y:-15},
    point3:{x:-15,y:340},
    point4:{x:30,y:340},
	strokeColor:cyan,
	debug:false,
	parent:"CamBlock",
}
addBlock(cambracket)

//
// color block
//
let colorblock  =
{
	name:"colorblock",
	type:RECT,
	x:20,
	y:20,
	layoutSpec:{x:1,y:1,fit:false},
	width:400,
	height:240,
	fillGradient:blockbackgrad,
	radius:radius,
	childBlock0: {type:TEXT,name:"beztitle",text:"Primary",size:20,x:10,y:198,padding:5,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
}
addBlock(colorblock)

for (g = 0; g < 3; g++)
{
	for (i = 0; i < 3; i++)
	{
		let label = "?"
		if (i == 0) { label = "R" }
		if (i == 1) { label = "G" }
		if (i == 2) { label = "B" }
		
		let name = "slider".concat(i.toString()).concat(g.toString())
		
		let slider = 
		{
			name:name,
			type:RECT,
			x:(28 * i) + (110 * g) + 10,
			y:30,
			width:20,
			height:160,
			radius:2,	
			strokeColor:cyansolid,
			strokeWidth:3,
			z:1,
			parent:"colorblock",
			
		 }
		 addBlock(slider)
		 
		 let slidername= "slidertitle".concat(i.toString())
		 let sliderlabel =  { type:TEXT,name:slidername,text:label,size:15,x:6,y:140,textColor:cyan,font:MainFont,parent: name}
		 addBlock(sliderlabel)
		 
		 let x = 1
		 let y = Math.floor((Math.random() * 60) + 10)
		 let width = 19
		 let height = Math.floor((Math.random() * 15) + 3)

		 let posblock = 
		 {
			 name:"posblock",
			 type:RECT,
			 x:x,
			 y:y,
			 width:width,
			 height:height,
			 fillColor:orange,
			 radius:2,
			 z:-1,
			 animation0:{property:"position",move:{x:0,y:Math.floor((Math.random() * 60) + 10)},duration:Math.floor((Math.random() * 8) + 1),autoReverses:true},
			 animation2:{property:"size",fromSize:{width:width,height:height},toSize:{width:width,height:height * 1.5},duration:1.0,autoReverses:true},
			 parent: name
		  }
		  addBlock(posblock)
	}
	 
	 
	let glabel = "?"
	if (g == 0) { glabel = "gamma" }
	if (g == 1) { glabel = "gain" }
	if (g == 2) { glabel = "black" }
	let grouplabel =  
	{
		 type:TEXT,
		 name:"grouplabel",
		 text:glabel,
		 size:15,
		 x:(25 * g * 5) + 10,
		 y:5,
		 textColor:black,
		 padding:3,
		 parent:"colorblock",
		 font:MainFont,
		 fillColor:gray,
		 strokeColor:gray,
		 radius:2
	 }
	 addBlock(grouplabel)
}

let colorcube = 
{
	name:"posblock",
	type:RECT,
	x:330,
	y:90,
	width:40,
	height:40,
	gradientAngle:0.0,
	strokeColor:cyan,
	strokeWidth:1,
	fillGradient:{ startColor: {red:1.0, green:0.0, blue:0.0, alpha:0.8},endColor: {red:0.0, green:0.9, blue:0.9, alpha:0.8}},
	radius:radius,
	parent: "colorblock",	
}
addBlock(colorcube)

let mapgrid =
{
	type:GRID,
	name:"mapgrid",
	layoutSpec:{x:1,y:0,fit:false},
	xspacing:10,
	yspacing:10,
	width:350,
	height:250,
	strokeColor:cyan,
	gridColor:cyan,
	childBlock0: {type:TEXT,name:"beztitle",text:"US",size:20,x:10,y:210,padding:5,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
}
addBlock(mapgrid)

let map = 
{
	type:IMAGE,
	name:"map",
	file:"map.png",
	x:0,
	y:0,
	width:350,
	height:250,
	//filter:{type:FILTER,name:"CIMotionBlur",inputRadius:30.0,inputAngle:5},
	filter:{type:FILTER,name:"CIBoxBlur",inputRadius:30.0},
	//filter:{type:FILTER,name:"CILinearGradient",inputPoint0:{x:10,y:10},inputPoint1:{x:100,y:100},inputColor0:blue,inputColor1:red},
	parent:"mapgrid"
}
addBlock(map)

let radar = 
{
	type:IMAGE,
	name:"radar",
	layoutSpec:{x:0,y:1,fit:false},
	//url:"https://www.weather.gov/images/gsp/tdwr/TCLT1842Refl.gif",
	//url:"https://ak6.picdn.net/shutterstock/videos/1020930286/thumb/12.jpg",
	url:"https://images5.alphacoders.com/294/294947.png",
	x:40,
	y:0,
	width:350,
	height:250,
	childBlock0: {type:TEXT,name:"beztitle",text:"TCLT1842Refl subpanel",size:20,x:10,y:210,padding:5,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
	//filter:{type:FILTER,name:"CIMotionBlur",inputRadius:10.0,inputAngle:5},
}
addBlock(radar)
	
let scrollblock1 =
{
	name:"scrollblock1",
	type:SCROLLTEXT,
	layoutSpec:{x:2,y:0,fit:false},
	width:400,
	height:250,
	radius:radius,
	clip:true,
	//textFile:"scrollingtext.txt",
	textURL:"https://robdodson.net/styles.css",
	size:14,
	font:MainFont,
	strokeColor:cyan,
	strokeWidth:2,
	textColor:cyan,
	animation1:{property:"scrollamount",max:-500,duration:15,autoReverses:false},
}
addBlock(scrollblock1)

let scrollblock2 =
{
	name:"scrollblock2",
	type:SCROLLTEXT,
	layoutSpec:{x:3,y:0,fit:false},
	width:400,
	height:250,
	radius:radius,
	clip:true,
	textFile:"scrollingtext.txt",
	size:14,
	font:MainFont,
	strokeColor:cyan,
	strokeWidth:1,
	textColor:gray,
	animation1:{property:"scrollamount",max:3000,duration:20,autoReverses:false},
}
addBlock(scrollblock2)

let titleblock =
{
	name:"titleblock",
	type:RECT,
	layoutSpec:{x:1,y:2,fit:false},
	x:40,
	y:100,
	width:300,
	height:200,
	fillGradient:blockbackgrad,
	//gradientAngle:90,
	radius:radius,
	childBlock0: {type:TEXT,name:"title",text:"Location: Central Core",size:20,x:10,y:180,textColor:gray,font:MainFont },
	childBlock1: {type:TEXT,name:"sub1",text:"IG. US",size:15,x:10,y:160,textColor:green,font:MainFont },
	childBlock2: {type:TEXT,name:"sub1",text:"Online",size:15,x:10,y:140,textColor:cyan,font:MainFont },
}
addBlock(titleblock)

//
// core
//
let cradius = 200
let cz = -100
let cb = .5
let cs = .1
for (r = 0; r < 30; r++)
{
	let core = 
	{
		type:CIRCLE,
		layoutSpec:{x:2,y:1,fit:false},
		name:"core",
		x:200,
		y:200,
		z:cz,
		radius:cradius,
		strokeWidth:8,
		strokeStart:cs,
		strokeEnd:.9,
		strokeColor:{red:0.0,green:0.0,blue:cb,alpha:.4},
	}
	
	cz += 10
	cradius -= 10
	cb += .1
	cs += .1
	
	addBlock(core)
}


//
// connected boxes BRK
// 
let contitle = 
{
	type:TEXT,
	name:"title",
	text:"BRK",
	padding:5,
	size:20,
	x:10,
	y:180,
	textColor:gray,
	font:MainFont,
	fillColor:gray,
	textColor:black,
	strokeColor:gray,
	radius:radius,
	layoutSpec:{x:0,y:0,fit:false},
}


let grad = {type:RECT,name:"icon", x:5,y:20,width:50,height:15,fillGradient:glowgrad,gradientAngle:90,}

addBlock(contitle)
let cbox1 = 
{
	name:"cbox1",
	type:RECT,
	layoutSpec:{x:0,y:0,fit:false},
	x:60,
	y:20,
	width:60,
	height:40,
	strokeColor:cyan,
	radius:radius,	
	childBlock0: grad,
	childBlock1: {type:TEXT,name:"title",text:"488",size:15,x:5,y:2,textColor:gray,font:MainFont },
}
addBlock(cbox1)

let cbox2 = 
{
	name:"cbox2",
	type:RECT,
	layoutSpec:{x:0,y:0,fit:false},
	x:140,
	y:20,
	width:60,
	height:40,
	strokeColor:cyan,
	radius:radius,
	childBlock0: grad,	
	childBlock1: {type:TEXT,name:"title",text:"788",size:15,x:5,y:2,textColor:gray,font:MainFont },
}
addBlock(cbox2)

let cbox3 = 
{
	name:"cbox3",
	type:RECT,
	layoutSpec:{x:0,y:0,fit:false},
	x:80,
	y:80,
	width:60,
	height:40,
	strokeColor:cyan,
	radius:radius,	
	childBlock0: grad,
	childBlock1: {type:TEXT,name:"title",text:"123",size:15,x:5,y:2,textColor:gray,font:MainFont },
}
addBlock(cbox3)

let cbox4 = 
{
	name:"cbox4",
	type:RECT,
	layoutSpec:{x:0,y:0,fit:false},
	x:180,
	y:80,
	width:40,
	height:70,
	strokeColor:cyan,
	radius:radius,	
	childBlock0:{type:CIRCLE,name:"circle1",x:12,y:10,radius:6,strokeColor:cyan,fillColor:red1,
		animation0:{property:"fillColor",fromColor:red1,toColor:green,duration:.75,repeatDuration:1000,autoReverses:true},},
	childBlock1:{type:CIRCLE,name:"circle1",x:12,y:25,radius:6,strokeColor:cyan,fillColor:red1},
	childBlock2:{type:CIRCLE,name:"circle1",x:12,y:40,radius:6,strokeColor:cyan,fillColor:red1},
	childBlock3:{type:CIRCLE,name:"circle1",x:12,y:55,radius:6,strokeColor:cyan,fillColor:red1,
		animation0:{property:"fillColor",fromColor:red1,toColor:green,duration:.25,repeatDuration:1000,autoReverses:true},},
}
addBlock(cbox4)


let cline1 = { type:LINE,name:"line1",x:120,y:40,endX:140,endY:40,strokeWidth:2,strokeColor:cyan,layoutSpec:{x:0,y:0,fit:false},}
addBlock(cline1)
let cline2 = { type:LINE,name:"line1",x:90,y:60,endX:90,endY:80,strokeWidth:2,strokeColor:cyan,layoutSpec:{x:0,y:0,fit:false},}
addBlock(cline2)
let cline3 = { type:LINE,name:"line1",x:140,y:100,endX:180,endY:100,strokeWidth:2,strokeColor:cyan,layoutSpec:{x:0,y:0,fit:false},}
addBlock(cline3)
let cline4 = { type:LINE,name:"line1",x:190,y:60,endX:190,endY:80,strokeWidth:2,strokeColor:cyan,layoutSpec:{x:0,y:0,fit:false},}
addBlock(cline4)


//
// Big Buttons
//
let buttitle = 
{
	type:TEXT,
	name:"title",
	text:"DISH",
	padding:5,
	size:20,
	x:10,
	y:180,
	textColor:gray,
	font:MainFont,
	fillColor:gray,
	textColor:black,
	strokeColor:gray,
	radius:4 ,
	layoutSpec:{x:3,y:1,fit:false},
}
addBlock(buttitle)

let bnum = 1
for (x = 0; x < 3; x++)
{
	for (y = 0; y < 3; y++)
	{
		let name = "button".concat(x.toString()).concat(y.toString())
		let color = gray
		if (y == 2 && x == 2) 
			color = orange
		 
		let b1 = 
		{
			name:name,
			type:RECT,
			layoutSpec:{x:3,y:1,fit:false},
			x:10 + (x * 65),
			y:10 + (y * 50),
			width:60,
			height:40,
			strokeColor:cyan,
			fillColor:cyan,
			radius:radius,	
			childBlock1: {type:TEXT,name:"title",text:bnum.toString(),size:40,x:17,y:-1,textColor:color,font:MainFont },
		}
		addBlock(b1)
		bnum++
	}
}

