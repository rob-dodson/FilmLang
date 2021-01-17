includeFile("../Constants")
includeFile("../BasicScreen")

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

		let scrollblock1 =
		{
			name:"scrollblock1",
			type:SCROLLTEXT,
			width:400,
			height:250,
			radius:4,
			clip:true,
			textURL:"/Users/robertdodson/Desktop/FILM/scrollingtext.txt",
			size:14,
			font:MainFont,
			strokeColor:cyan,
			strokeWidth:2,
			textColor:green,
			animator0:{value:"scrollamount",amount:2*x,min:0,max:-3000.0,type:INC},
			parent:name
		}
		addBlock(scrollblock1)
	}
}

