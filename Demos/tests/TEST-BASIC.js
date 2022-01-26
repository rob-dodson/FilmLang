includeFile("Constants")
includeFile("BasicScreen")

let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:100,
	y:100,
	width:400,
	height:400,
	fillGradient:blockbackgrad,
	strokeColor:orange,
	strokeWidth:5,
	radius:4,

//	animator0:{value:"x",amount:10,min:0,max:500,type:BOUNCE},
//	animator1:{value:"width",amount:10,min:400,max:500,type:BOUNCE},
	childBlock0: {type:TEXT,name:"beztitle0",text:"BEZ-1",size:20,x:70,y:240,textColor:gray,font:"Futura",textColor:blue,strokeColor:orange,radius:4,padding:5},
//	childBlock1: {type:TEXT,name:"beztitle1",text:"BEZ-2",size:20,x:70,y:200,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,fillColor:red,padding:5},
//	childBlock2: {type:TEXT,name:"beztitle2",text:"BEZ-3",size:20,x:70,y:150,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5,rotation:0,},
////	childBlock3: {type:TEXT,name:"beztitle3",text:"FOO 0",size:20,x:70,y:90,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5,rotation:0,animator0:{value:"rotation",amount:1,min:0,max:360,type:BOUNCE}},
//	childBlock4: {type:RECT,name:"bezrect0",x:170,y:140,width:50,height:50,rotation:45,strokeColor:orange,radius:4,fillColor:green,animator0:{value:"rotation",amount:5,min:0,max:360,type:BOUNCE}},
//	childBlock5: {type:CIRCLE,name:"bezcircl0",x:270,y:40,strokeColor:orange,radius:40,fillColor:green,animator0:{value:"x",amount:12,min:70,max:100,type:BOUNCE},childBlock0: {type:CIRCLE,name:"bezcircl0s",x:20,y:20,rotation:45,strokeColor:red,radius:20,fillColor:blue}},
}
addBlock(bezblock)
