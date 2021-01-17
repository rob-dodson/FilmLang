includeFile("../Constants")

includeFile("../BasicScreen")

let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:100,
	y:100,
	width:40,
	height:40,
	fillColor:black,
	strokeColor:orange,
	strokeWidth:5,
	radius:4,
}
addBlock(bezblock)

for (i = 0 ; i < 10 ; i++)
{
	let bezblock2 =
	{
		name:"bezblock2",
		type:RECT,
		x:160 + (i * 10),
		y:160 + (i * 10),
		width:40,
		height:40,
		fillColor:red,
		strokeColor:orange,
		strokeWidth:5,
		radius:4,
		waitStartSeconds:2.0 + i,
		waitEndSeconds:4.0 + i,
		animation1:{property:"position",move:{x:100,y:100},duration:2.0,autoReverses:true},
	}
	addBlock(bezblock2)
}

