let scrollblock =
{
    name:"scrollblock",
    type:SCROLLTEXT,
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
	animator0:{value:"scrollamount",amount:10,min:0,max:600.0,type:INC},
}
addBlock(scrollblock)

let scrollblock1 =
{
	name:"scrollblock1",
	type:SCROLLTEXT,
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
	animator0:{value:"scrollamount",amount:20,min:0,max:600.0,type:INC},
}
addBlock(scrollblock1)
