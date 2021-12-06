includeFile("../Constants")
includeFile("../BasicScreen")

let layoutx = 5
let layouty = 5

let layout =
{
	type:LAYOUT,
	name:"layout",
	xcount:layoutx,
	ycount:layouty,
	debug:false,
	debugColor:gray,
}
addBlock(layout)

for (x = 0; x < 4; x++)
{
	for (y = 0; y < 4; y++)
	{
		let	name = "back".concat(x.toString()).concat(y.toString())

		let back = 
		{
			name:name,
			width:400,
			height:250,
			type:RECT,
			fillColor:cyan,
			strokeColor:orange,
			strokeWidth:2,
			layoutSpec:{x:x,y:y,fit:false},
		}
		addBlock(back)

		let	blockname = "block".concat(x.toString()).concat(y.toString())
		
		
		
		let scrollblock1 =
		{
			name:blockname,
			type:SCROLLTEXT,
			width:400,
			height:250,
			radius:4,
			clip:true,
			textFile:"/Users/robertdodson/Desktop/foo.txt",
			size:14,
			font:MainFont,
			strokeColor:cyan,
			strokeWidth:2,
			textColor:green,
			animation1:{property:"scrollamount",max:-3000,duration:115,autoReverses:false},
			parent:name
		}
		addBlock(scrollblock1)
	}
}

