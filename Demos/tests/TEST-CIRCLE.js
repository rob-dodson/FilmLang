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


let dur = 1.25
let rev = true

/*for (x = 1; x <= XX; x++)
{
	for (y = 1; y <= YY; y++)
	{
		let name = "circle".concat(x.toString()).concat(y.toString())
		let circle =
		{
			name:name,
			type:CIRCLE,
			debug:false,
			radius:15,
			x:0,
			y:0,
			center:true,
			layoutSpec:{x:x - 1,y:y - 1,fit:true},
			strokeColor:orange,
			fillColor:blue,
			strokeWidth:2,
			//childBlock0: {type:TEXT,name:"title",text:name,size:15,x:10,y:40,textColor:red,font:MainFont },
			lineCap:"round",
			animation0:{property:"strokeStart",from:.0,to:.5,duration:dur,autoReverses:rev},
            animation1:{property:"strokeEnd",from:.5,to:1.0,duration:dur,autoReverses:rev},
			//animation2:{property:"radius",from:10,to:150,duration:dur,autoReverses:rev},
			//animation3:{property:"position",move:{x:-75,y:-75},duration:dur,autoReverses:rev},
			animation4:{property:"opacity",from:.3,to:1,duration:dur,autoReverses:rev},
			animation5:{property:"lineWidth",from:1,to:15,duration:.5,autoReverses:rev},
			animation6:{property:"strokeColor",fromColor:blue,toColor:red,duration:dur,autoReverses:rev},
			animation7:{property:"transform.rotation.z",from:0,to:6,duration:dur,autoReverses:rev},
			//animation8:{property:"transform.rotation.x",from:0,to:6,duration:dur,autoReverses:rev},
		}
		addBlock(circle)
	}
}
*/

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
		type:CIRCLE,
		name:name,
		x:xr,
		y:yr,
		radius:Math.random() * 40 + 5,
		strokeColor:rancolor,
		strokeWidth:2,
		fillColor:rancolor2,
		animation0:{property:"transform.rotation.z",from:0,to:Math.random() * 17 + 1,duration:2.0,autoReverses:false},
		animation1:{property:"transform.rotation.x",from:0,to:Math.random() * 17 + 1,duration:2.0,autoReverses:false},
	}
	addBlock(b1)
}