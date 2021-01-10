let mapgrid =
{
	type:GRID,
	name:"mapgrid",
	layoutSpec:{x:1,y:0,fit:false},
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
	//filter:{type:FILTER,name:"CIMotionBlur",inputRadius:30.0,inputAngle:5},
	//filter:{type:FILTER,name:"CIBoxBlur",inputRadius:80.0},
	//filter:{type:FILTER,name:"CILinearGradient",inputPoint0:{x:10,y:10},inputPoint1:{x:100,y:100},inputColor0:blue,inputColor1:red},
	parent:"mapgrid"
}
addBlock(map)
	
