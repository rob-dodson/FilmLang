let scrollblock1 =
{
	name:"scrollblock1",
	type:SCROLLTEXT,
	layoutSpec:{x:2,y:0,fit:false},
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
	animation1:{property:"scrollamount",max:-3000,duration:15,autoReverses:false},
}
addBlock(scrollblock1)

let scrollblock2 =
{
	name:"scrollblock2",
	type:SCROLLTEXT,
	layoutSpec:{x:3,y:0,fit:false},
	width:400,
	height:250,
	radius:4,
	clip:true,
	textURL:"/Users/robertdodson/Desktop/FILM/scrollingtext.txt",
	size:14,
	font:MainFont,
	strokeColor:cyan,
	strokeWidth:1,
	textColor:gray,
	animation1:{property:"scrollamount",max:3000,duration:20,autoReverses:false},
}
addBlock(scrollblock2)
