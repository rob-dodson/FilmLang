let scrollblock =
{
    name:"scrollblock",
    type:SCROLLTEXT,
    x:20,
    y:20,
    layoutSpec:{x:3,y:0,fit:false},
    width:400,
    height:200,
    radius:4,
	clip:true,
	textURL:"/Users/robertdodson/Desktop/FILM/FILM.js",
	size:10,
	font:MainFont,
	strokeColor:cyan,
	textColor:cyan,
	animator0:{value:"scrollamount",amount:-1,min:-5000.0,max:0.0,type:INC},
}
addBlock(scrollblock)

let scrollblock1 =
{
	name:"scrollblock1",
	type:SCROLLTEXT,
	x:20,
	y:20,
	layoutSpec:{x:3,y:1,fit:false},
	width:400,
	height:200,
	radius:4,
	clip:true,
	textURL:"/Users/robertdodson/Documents/BeechwoodsNotes.txt",
	size:10,
	font:MainFont,
	strokeColor:cyan,
	textColor:blue,
	animator0:{value:"scrollamount",amount:-.5,min:-5000.0,max:0.0,type:INC},
}
addBlock(scrollblock1)
