includeFile("Constants")
includeFile("BasicScreen")


let layoutx = 5
let layouty = 5
let htime = 3.5

let layout =
{
    type:LAYOUT,
    name:"layout",
    xcount:layoutx,
    ycount:layouty,
    debug:false,
    debugColor:gray,
}
addBlock(layout)

let bigbez =
{
    name:"bigbez",
    type:BEZIER,
	debug:true,
    x:0,
    y:0,
    strokeWidth:5,
    strokeColor:cyan,
	layoutSpec:{x:1,y:1,fit:true},
    point0:{ x: 10,  y: 10 },
    point1:{ point:{ x: 100,  y: 190 }, controlPoint1:{ x: 45, y: 200  }, controlPoint2:{ x: 80, y: 220 }},
    point2:{ point:{ x: 145, y: 15  }, controlPoint1:{ x: 120, y: 180 }, controlPoint2:{ x: 135,  y: 20 }},
    point3:{ point:{ x: 190, y: 0   }, controlPoint1:{ x: 155, y: -10 }, controlPoint2:{ x: 190, y: 0 }},
}
addBlock(bigbez)

let circle =
{
	name:"circle",
	type:CIRCLE,
	radius:40,
	center:true,
	debug:true,
	layoutSpec:{x:4,y:1,fit:true},
	x:0,
	y:0,
	strokeColor:orange,
	strokeWidth:5,
}
addBlock(circle)


let line2 =
{
	type:LINE,
	name:"line",
	x:10,
	y:10,
	debugColor:green,
	endX:200,
	endY:200,
	layoutSpec:{x:3,y:2,fit:true},
	strokeWidth:10,
	strokeColor:orange,
	lineCap:"round",
	debug:true,
	animation0:{property:"strokeStart",from:1.0,to:.0,duration:2.4,autoReverses:true},
//	animation1:{property:"strokeEnd",from:1.0,to:.5,duration:2.4,autoReverses:true},
}
addBlock(line2)

