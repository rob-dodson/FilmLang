let mapgrid =
{
	type:GRID,
	name:"mapgrid",
	layoutSpec:{x:2,y:1,fit:false},
	xspacing:10,
	yspacing:10,
	width:350,
	height:250,
	strokeColor:cyan,
	gridColor:cyan,
}
addBlock(mapgrid)
let map = 
{
	type:IMAGE,
	
	name:"map",
	url:"file:///Users/robertdodson/Desktop/FILM/map.png",
	x:0,
	y:0,
	width:350,
	height:250,
	parent:"mapgrid"
}
addBlock(map)
	