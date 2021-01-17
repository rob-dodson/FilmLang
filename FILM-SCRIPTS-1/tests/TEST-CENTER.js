includeFile("../Constants")
includeFile("../BasicScreen")

let dur = 0.4 
let rev = true

	let line2 = 
	{
		type:RECT,
		name:"rect",
		x:0,
		y:0,
		width:200,
		height:200,
		strokeWidth:5,
		strokeColor:orange,
		lineCap:"round",
		debug:true,
		center:true,
		childBlock0: {type:RECT,name:"center", x:0,y:0,width:30,height:15,fillColor:green,center:true },
	}

	addBlock(line2)

