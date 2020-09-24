let RECT = "Rect"
let TEXT = "Text"
let green = ".0,.9,.0,0.9"

for (i = 1; i < 10 ; i++)
{
	let rectname = "rect".concat(i.toString())
	let rect1 = 
	{ 
		type:RECT, 
		name:rectname, 
		x:60 * i, 
		y:150,
		width:50, 
		height:50, 
		radius:1,
		strokeWidth:1,
		fillColor:".5,.5,.5,0.5", 
		strokeColor:green,
		rotation:10
	}
	addBlock(rect1)

	let textname = "text".concat(i.toString())
	let text1 = 
	{
		type:TEXT,
		name:textname,
		size:15,
		x: 10,
		y: 20,
		text:"HI",
		textColor:green,
		parent:rectname
	}
	addBlock(text1)

}

