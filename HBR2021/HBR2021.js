//
// HBR2021
//
includeFile("Constants")
includeFile("Gradients")
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


let sound  =
{
    name:"sound1",
    type:SOUND,
    File:"Message.mp3",
}
//addBlock(sound)

let music  =
{
    name:"music",
    type:SOUND,
    File:"Philip.m4a",
    waitStartSeconds:3.0,
}
addBlock(music)



let HBRText =
{
	type:TEXT,
	name:"hbrtext",
	text:"HBR2021",
	layoutSpec:{x:2,y:2,fit:true},
	size:50,
	font:"Futura",
	textColor:green,
    waitStartSeconds:.5,
	animation0:{property:"transform.scale.x",from:1,to:5,duration:htime,autoReverses:false},
	animation1:{property:"transform.scale.y",from:1,to:5,duration:htime,autoReverses:false},
    waitEndSeconds:htime - .25,
}
addBlock(HBRText)


for (x = 0; x < layoutx; x++)
{
	for (y = 0; y < layouty; y++)
	{
		let name = "circle".concat(x.toString().concat(y.toString()))

		let b1 =
		{
			type:CIRCLE,
			name:name,
			layoutSpec:{x:x,y:y,fit:true},
			radius:35,
            x:0,
            y:0,
            center:true,
            strokeColor:orange,
            strokeWidth:2,
            childBlock0: {type:TEXT,name:"title",text:"HBR",size:15,x:10,y:40,textColor:red,font:MainFont },
			waitStartSeconds:htime + 1,
            animation7:{property:"transform.rotation.z",from:0,to:6,duration:4.0,autoReverses:true},
            animation8:{property:"transform.rotation.x",from:0,to:6,duration:4.0,autoReverses:true},
			waitEndSeconds:htime + htime + 4.25,
		}
		addBlock(b1)


		btime = htime + htime + 5.0
		let b2 =
		{
			name:"b2",
			type:RECT,
			layoutSpec:{x:x,y:y,fit:true},
			width:40,
			height:40,
			fillColor:red,
			strokeColor:orange,
			strokeWidth:5,
			radius:4,
			waitStartSeconds:btime + x,
			waitEndSeconds:btime + 4.0 + x,
			animation0:{property:"position",move:{x:15,y:15},duration:2.0,autoReverses:true},
			animation1:{property:"opacity",from:.3,to:1,duration:2.0,autoReverses:true},
		}
		addBlock(b2)
		

		ctime = btime + 8.0
        let bname = "back".concat(x.toString()).concat(y.toString())

        let back =
        {
            name:bname,
            width:180,
            height:180,
            type:RECT,
            layoutSpec:{x:x,y:y,fit:false},
			waitStartSeconds:ctime + x,
			waitEndSeconds:ctime + 4.0 + x,
        }
        addBlock(back)

		let duration = Math.random(20) + 2
        let scrollblock1 =
        {
            name:"scrollblock1",
            type:SCROLLTEXT,
            width:180,
            height:180,
            clip:true,
            textURL:"text.txt",
            size:14,
            font:MainFont,
            strokeColor:cyan,
            textColor:green,
			animation0:{property:"scrollamount",max:300,duration:duration,autoReverses:true},
			waitStartSeconds:ctime + x,
			waitEndSeconds:ctime + 4.0 + x,
            parent:bname
        }
        addBlock(scrollblock1)

    }
}

let H =
{
    name:"H",
    type:PATH,
    strokeWidth:2,
	layoutSpec:{x:1,y:1,fit:true},

	point0: {x: 30.5, y: 159.5},
	point1: {x: 30.5, y: 33.5},
	point2: {x: 56.55, y: 33.5},
	point3: {x: 56.55, y: 83.47},
	point4: {x: 91.28, y: 83.47},
	point5: {x: 91.28, y: 33.5},
	point6: {x: 119.5, y: 33.5},
	point7: {x: 119.5, y: 159.5},
	point8: {x: 91.28, y: 159.5},
	point9: {x: 91.28, y: 103.02},
	point10: {x: 56.55, y: 103.02},
	point11: {x: 56.55, y: 159.5},
	point12: {x: 30.5, y: 159.5},

	closePath:true,
    strokeColor:green,
    debug:false,
	animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
}
addBlock(H)





let B =
{
    name:"B",
    type:BEZIER,
    strokeWidth:2,
    layoutSpec:{x:1,y:1,fit:true},

	point1:  { x: 50.37, y: 81.00},
	point2:  { point:{x: 63.08, y: 83.35},  controlPoint1: {x: 55.33, y: 81.00},  controlPoint2: {x: 59.57, y: 81.78}},
	point3:  { point:{x: 71.17, y: 90.10},  controlPoint1: {x: 66.59, y: 84.92},  controlPoint2: {x: 69.29, y: 87.17}},
	point4:  { point:{x: 74.00, y: 100.65}, controlPoint1: {x: 73.06, y: 93.02},  controlPoint2: {x: 74.00, y: 96.54}},
	point5:  { point:{x: 72.09, y: 108.92}, controlPoint1: {x: 74.00, y: 103.75}, controlPoint2: {x: 73.36, y: 106.51}},
	point6:  { point:{x: 66.7,  y: 114.81}, controlPoint1: {x: 70.82, y: 111.33}, controlPoint2: {x: 69.02, y: 113.29}},
	point7:  { point:{x: 58.44, y: 117.67}, controlPoint1: {x: 64.38, y: 116.33}, controlPoint2: {x: 61.63, y: 117.29}},
	point8:  { x: 58.44, y: 118.45},
	point9:  { point:{x: 64.53, y: 121.26}, controlPoint1: {x: 60.70, y: 118.87}, controlPoint2: {x: 62.73, y: 119.81}},
	point10: { point:{x: 68.85, y: 126.67}, controlPoint1: {x: 66.33, y: 122.72}, controlPoint2: {x: 67.77, y: 124.52}},
	point11: { point:{x: 70.47, y: 133.54}, controlPoint1: {x: 69.93, y: 128.82}, controlPoint2: {x: 70.47, y: 131.11}},
	point12: { point:{x: 67.98, y: 142.83}, controlPoint1: {x: 70.47, y: 137.13}, controlPoint2: {x: 69.64, y: 140.22}},
	point13: { point:{x: 60.88, y: 148.87}, controlPoint1: {x: 66.33, y: 145.43}, controlPoint2: {x: 63.96, y: 147.44}},
	point14: { point:{x: 49.84, y: 151.00}, controlPoint1: {x: 57.80, y: 150.29}, controlPoint2: {x: 54.12, y: 151.00}},
	point15: { x: 23.17, y: 151.00},
	point16: { x: 23.17, y:  81.00},
	point17: { x: 50.37, y:  81.00},

	scalePath:2.0,
	closePath:true,
    strokeColor:green,
    debug:false,
    animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
}
addBlock(B)



let R =
{
    name:"R",
    type:BEZIER,
    strokeWidth:2,
    layoutSpec:{x:1,y:1,fit:true},

point1: {x: 99.01, y: 108.7},
point2: {x: 116.45, y: 108.7},
point3: {x: 116.45, y: 108.7},
point4: {x: 116.45, y: 108.7},
point5: {x: 131.63, y: 81},
point6: {x: 142, y: 81},
point7: {x: 125.59, y: 110.06},
point8: {point: {x: 136.06, y: 117.48}, controlPoint1: {x: 130.05, y: 111.45}, controlPoint2: { x: 133.53, y: 113.92}},
point9: {point: {x: 139.84, y: 130.14}, controlPoint1: {x: 138.58, y: 121.04}, controlPoint2: { x: 139.84, y: 125.26}},
point10: {point: {x: 137.04, y: 141.13}, controlPoint1: {x: 139.84, y: 134.34}, controlPoint2: { x: 138.9, y: 138.01}},
point11: {point: {x: 129.15, y: 148.4}, controlPoint1: {x: 135.17, y: 144.25}, controlPoint2: { x: 132.54, y: 146.67}},
point12: {point: {x: 117.24, y: 151}, controlPoint1: {x: 125.76, y: 150.13}, controlPoint2: { x: 121.79, y: 151}},
point13: {x: 90.17, y: 151},
point14: {x: 90.17, y: 81},
point15: {x: 99.01, y: 81},
point16: {x: 99.01, y: 108.7},


	scalePath:2.0,
	closePath:true,
    strokeColor:green,
    debug:false,
    animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
}
addBlock(R)

