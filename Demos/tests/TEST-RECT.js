includeFile("Constants")
includeFile("BasicScreen")


let XX = 15 
let YY = 15 
let layout =
{
	type:LAYOUT,
	name:"layout",
	xcount:XX,
	ycount:YY,
	debug:false,
}
addBlock(layout)




for (x = 0; x < 50; x++)
{
	let r = Math.random()
	let g = Math.random()
	let b = Math.random()
	let rancolor  = { red:r, green:g, blue:b, alpha:0.8}
	
	let r2 = Math.random()
	let g2 = Math.random()
	let b2 = Math.random()
	let rancolor2  = { red:r2, green:g2, blue:b2, alpha:0.3}
	
	let xr = (Math.random() * 2000) + 20
	let yr = (Math.random() * 2000) + 20
	let name = "circle2".concat(xr.toString())
	
	let b1 =
	{
		type:RECT,
		name:name,
		x:xr,
		y:yr,
		width:40,height:50,
		radius: 5,
		strokeColor:rancolor,
		strokeWidth:2,
		fillColor:rancolor2,
		animation0:{property:"transform.rotation.z",from:0,to:Math.random() * 17 + 1,duration:2.0,autoReverses:false},
		animation1:{property:"transform.rotation.x",from:0,to:Math.random() * 17 + 1,duration:2.0,autoReverses:false},
	}
	addBlock(b1)
}