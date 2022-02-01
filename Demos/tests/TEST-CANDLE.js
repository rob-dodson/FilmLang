includeFile("Constants")
includeFile("BasicScreen")





for (i = 0 ; i < 10 ; i++)
{
	let r = Math.random()
	let g = Math.random()
	let b = Math.random()
	let rancolor  = { red:r, green:g, blue:b, alpha:0.5}
	
	let r2 = Math.random()
	let g2 = Math.random()
	let b2 = Math.random()
	let rancolor2  = { red:r2, green:g2, blue:b2, alpha:0.3}
	
	let width = 30
	let ranheight = Math.random() * 200 + 100
	
	name = "candle".concat(i.toString())

	let candle =
	{
		type:RECT,
		name:name,
		x:100 + (i * 100),
		y:10,
		width:width,
		height:ranheight,
		radius: 2,
		fillGradient: { startColor: rancolor, endColor: rancolor2 },
		gradientAngle:90,
	}
	addBlock(candle)
	
	let flameheight = Math.random() * 20 + 130
	let flame = 
	{ 
		type:PATH,
		name:"flame",
		fillColor:orange,
		point0:{x: width / 2, y: ranheight},
		point1:{x: (width / 2) + (width / 2), y: ranheight + 50},
		point2:{x: width / 2, y: ranheight + flameheight},
		point3:{x: 0, y: ranheight + 50},
		point4:{x: width / 2, y: ranheight},
		closePath:true,
		//fillGradient: { startColor: rancolor, endColor: rancolor2 },
		animation0:{property:"position",move:{x:0,y:Math.random() * 10 + 3},duration:.05,autoReverses:true},
		
		parent:name,
	}
	addBlock(flame)
}
