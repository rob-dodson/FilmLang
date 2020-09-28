
let titleblock =
{
	name:"titleblock",
	type:RECT,
	x:500,
	y:750,
	width:200,
	height:100,
	fillGradient:blockbackgrad,
	radius:4,
	childBlock0: {type:TEXT,name:"title",text:"central core",size:20,x:10,y:40,textColor:gray,font:MainFont },
	childBlock1: {type:TEXT,name:"sub1",text:"IG. US",size:15,x:10,y:10,textColor:black,font:MainFont },
}
addBlock(titleblock)

let testbez =
{
	name:"testbez",
	type:BEZIER,
	x:500,
	y:750,
	strokeWidth:5,
    point0:{x: 29.5, y: 73.5},
    point1:{point:{x: 58.5, y: 57.5},controlpoint1:{x: 29.5, y: 73.5},controlpoint2:{x: 42.5, y: 57.5}},
    point2:{point:{x: 90.5, y: 73.5},controlpoint1:{x: 74.5, y: 57.5},controlpoint2:{x: 90.5, y: 73.5}},
    strokeColor:blue,
}
addBlock(testbez)

