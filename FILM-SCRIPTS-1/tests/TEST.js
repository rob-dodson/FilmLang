includeFile("../Constants")
includeFile("../BasicScreen")


let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:20,
	y:20,
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	strokeColor:orange,
	strokeWidth:5,
	radius:4,
//	animator0:{value:"x",amount:10,min:0,max:500,type:BOUNCE},
	childBlock0: {type:TEXT,name:"beztitle",text:"BEZ-1",size:64,x:40,y:20,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,padding:5},
	childBlock1: {type:TEXT,name:"beztitle",text:"BEZ-1",size:42,x:40,y:120,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,fillColor:red,padding:5},
	childBlock2: {type:TEXT,name:"beztitle",text:"primary BEZ-1",size:22,x:40,y:220,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5},
}
addBlock(bezblock)

