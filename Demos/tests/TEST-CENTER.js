includeFile("Constants")
includeFile("BasicScreen")


let line2 = 
{
	type:RECT,
	name:"rect",
	x:0,
	y:0,
	width:200,
	height:200,
	strokeWidth:1,
	strokeColor:orange,
	lineCap:"round",
	debug:false,
	center:true,
	childBlock0: { type:RECT,name:"center", center:true,width:30,height:45,fillColor:{red:.3,green:.5,blue:.8,alpha:.9} },
}

addBlock(line2)

