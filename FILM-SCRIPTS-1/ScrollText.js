let scrollblock1 =
{
	name:"scrollblock1",
	type:SCROLLTEXT,
	layoutSpec:{x:2,y:0,fit:false},
	width:400,
	height:200,
	radius:4,
	clip:true,
	textURL:"/Users/robertdodson/Desktop/FILM/scrollingtext.txt",
	size:14,
	font:MainFont,
	strokeColor:cyansolid,
	strokeWidth:5.0,
	textColor:cyan,
	animator0:{value:"scrollamount",amount:15,min:0,max:3000.0,type:BOUNCE},
}
addBlock(scrollblock1)
