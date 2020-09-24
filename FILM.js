let RECT = "Rect"
let TEXT = "Text"
let green = ".0,.9,.0,0.9"
let red = ".9,.9,.0,1.0"

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
	}
	addBlock(rect1)

	let textname = "text".concat(i.toString())
	let text1 = 
	{
		type:TEXT,
		name:textname,
		size:15,
		x: 15,
		y: 20,
		text:"Ok",
		textColor:green,
		parent:rectname
	}
	addBlock(text1)

}

	let rectname = "rectA"
	let rect1 = 
	{ 
		type:RECT, 
		name:rectname, 
		x:60 * 10, 
		y:150,
		width:50, 
		height:50, 
		radius:1,
		strokeWidth:1,
		fillColor:".5,.5,.5,0.5", 
		strokeColor:green,
	}
	addBlock(rect1)

	let textname = "textA"
	let text1 = 
	{
		type:TEXT,
		name:textname,
		size:15,
		x: 25,
		y: 20,
		text:"Alert",
		textColor:red,
		parent:rectname
	}
	addBlock(text1)


