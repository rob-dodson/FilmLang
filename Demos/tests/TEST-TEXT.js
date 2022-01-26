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

	//childBlock0: {type:TEXT,name:"beztitle",text:"nO CenTER BEZ-1",size:20,x:70,y:240,textColor:gray,font:"Futura",textColor:blue,strokeColor:orange,radius:4,padding:5},

	childBlock1: {type:TEXT,name:"center",text:"This Text is Centered?",size:20,center:true,textColor:red,font:"Futura",strokeColor:green,radius:4,padding:15},

	//childBlock2: {type:TEXT,name:"beztitle",text:"BEZ-2",size:20,x:70,y:200,textColor:gray,font:"Futura",textColor:black,strokeColor:orange,radius:4,fillColor:red,padding:5},

	//childBlock3: {type:TEXT,name:"beztitle",text:"BEZ-3",size:20,x:70,y:150,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5,rotation:0,},

	//childBlock4: {type:TEXT,name:"beztitle",text:"FOO 0",size:20,x:70,y:90,textColor:gray,font:"Courier",textColor:black,strokeColor:orange,radius:4,fillGradient:redgrad,padding:5,rotation:0,animator0:{value:"rotation",amount:1,min:0,max:360,type:BOUNCE}},
}
addBlock(bezblock)
