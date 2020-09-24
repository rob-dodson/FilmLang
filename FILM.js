for (i = 0; i < 10 ; i++)
{
	let n = "rect"
	let name = n.concat(i.toString()) 

let rect1 = { type:"Rect", 
	name:name, 
	x:50 * i, 
	y:50 * i, 
	width:100, 
	height:100, 
	fillColor:".5,.5,.5,0.5", 
	strokeColor:"1.0,0.0,0.0,1.0"}
addBlock(rect1)

let rect2 = { type:"Rect", 
	name:"Rect2", 
	x:30, 
	y:30, 
	width:20, 
	height:20, 
	fillColor:".0,.0,.5,0.5", 
	strokeColor:"1.0,1.0,0.0,1.0",
	parent:name}
addBlock(rect2)
}
