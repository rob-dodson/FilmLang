//
// color block
//
let colorblock  =
{
	name:"colorblock",
	type:RECT,
	x:20,
	y:20,
	layoutSpec:{x:1,y:1,fit:false},
	width:400,
	height:240,
	fillGradient:blockbackgrad,
	radius:4,
	childBlock0: {type:TEXT,name:"beztitle",text:"primary",size:20,x:10,y:210,textColor:gray,font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4 },
}
addBlock(colorblock)

for (g = 0; g < 3; g++)
{
	for (i = 0; i < 3; i++)
	{
		let label = "?"
		if (i == 0) { label = "R" }
		if (i == 1) { label = "G" }
		if (i == 2) { label = "B" }
		
		let name = "slider".concat(i.toString()).concat(g.toString())
		
		let slider = 
		{
			name:name,
			type:RECT,
			x:(28 * i) + (110 * g) + 10,
			y:30,
			width:20,
			height:160,
			radius:2,	
			strokeColor:cyan,
			strokeWidth:3,
			parent:"colorblock",
			
		 }
		 addBlock(slider)
		 
		 let slidername= "slidertitle".concat(i.toString())
		 let sliderlabel =  { type:TEXT,name:slidername,text:label,size:15,x:6,y:140,textColor:cyan,font:MainFont,parent: name}
		 addBlock(sliderlabel)
		 
		 let posblock = 
		 {
			 name:"posblock",
			 type:RECT,
			 x:1,
			 y:Math.floor((Math.random() * 60) + 10),
			 width:19,
			 height:Math.floor((Math.random() * 15) + 3),
			 fillColor:orange,
			 radius:2,
			 parent: name
		  }
		  addBlock(posblock)
	}
	 
	 
	let glabel = "?"
	if (g == 0) { glabel = "gamma" }
	if (g == 1) { glabel = "gain" }
	if (g == 2) { glabel = "black" }
	let grouplabel =  
	{
		 type:TEXT,
		 name:"grouplabel",
		 text:glabel,
		 size:15,
		 x:(25 * g * 5) + 10,
		 y:5,
		 textColor:cyan,
		 parent:"colorblock",
		 font:MainFont,fillColor:gray,textColor:black,strokeColor:gray,radius:4
	 }
	 addBlock(grouplabel)
}