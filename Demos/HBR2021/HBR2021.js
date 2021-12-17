//
// HBR2022
//
includeFile("Constants")
includeFile("Gradients")
includeFile("BasicScreen")


let layoutx = 5
let layouty = 5
 
let time1 = 3.5
let time1duration = 7.0 

let time2 = time1 + time1duration - 1.0
let time2duration = 8.0 

let time3 = time2 + time2duration
let time3duration = 4.0 

let time4 = time3 + 8.0
let time4duration = 8.0 

let time5 = time4 + time4duration
let time5duration = 5.0 

let time6 = time5 + time5duration
let time6duration = 4.0 

let time7 = time6 + time6duration
let time7duration = 3.0 

let time8 = time7 + time7duration
let time8duration = 5.0 

let time9 = time8 + time8duration
let time9duration = 5.0 

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
addBlock(sound)

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
	text:"HBR2022",
	layoutSpec:{x:2,y:2,fit:true},
	size:50,
	font:"Futura",
	textColor:fillmain,
    waitStartSeconds:.5,
	animation0:{property:"transform.scale.x",from:1,to:5,duration:2.0,autoReverses:false},
	animation1:{property:"transform.scale.y",from:1,to:5,duration:2.0,autoReverses:false},
    waitEndSeconds:4,
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
            center:true,
            strokeColor:orange,
            strokeWidth:2,
            childBlock0: {type:TEXT,name:"title",text:"HBR",size:15,center:true,textColor:red,font:MainFont },
			waitStartSeconds:time1 + 1,
            animation7:{property:"transform.rotation.z",from:0,to:6,duration:4.0,autoReverses:true},
            animation8:{property:"transform.rotation.x",from:0,to:6,duration:4.0,autoReverses:true},
			waitEndSeconds:time1 + time1duration,
		}
		addBlock(b1)


		let b2 =
		{
			name:"b2",
			type:RECT,
			layoutSpec:{x:x,y:y,fit:true},
			width:40,
			height:40,
			fillColor:fillmain,
			strokeColor:orange,
			strokeWidth:5,
			radius:4,
			center:true,
			waitStartSeconds:time2 + x,
			waitEndSeconds:time2 + time2duration + x,
			animation0:{property:"position",move:{x:40,y:40},duration:3,autoReverses:true},
			animation1:{property:"opacity",from:.3,to:1,duration:2.0,autoReverses:true},
			animation2:{property:"transform.rotation.z",from:0,to:6,duration:Math.random(4),autoReverses:true},
		}
		addBlock(b2)
		

        let bname = "back".concat(x.toString()).concat(y.toString())

        let back =
        {
            name:bname,
            width:180,
            height:180,
            type:RECT,
            layoutSpec:{x:x,y:y,fit:false},
			waitStartSeconds:time3 + x,
			waitEndSeconds:time3 + time3duration + x,
        }
        addBlock(back)

		let duration = Math.random(15) + 2
		let r = Math.random()
		let g = Math.random()
		let b = Math.random()
		let rancolor  = { red:r, green:g, blue:b, alpha:0.8}
        let scrollblock1 =
        {
            name:"scrollblock1",
            type:SCROLLTEXT,
            width:180,
            height:180,
            clip:true,
            textFile:"text.txt",
            size:14,
            font:MainFont,
            strokeColor:cyan,
            textColor:rancolor,
			animation0:{property:"scrollamount",max:Math.random(250) + 20,duration:Math.random(10),autoReverses:true},
			waitStartSeconds:time3 + x,
			waitEndSeconds:time3 + time3duration + x,
            parent:bname
        }
        addBlock(scrollblock1)

    }
}


let HBRParent = 
{
	name:"HBRParent",
	center:true,
	width:700,
	height:400,
	type:RECT,
	debug:false,
}
addBlock(HBRParent)


let HParent = 
{
	name:"HParent",
	x:0,
	y:0,
	width:180,
	height:280,
	type:RECT,
	debug:false,
	parent:"HBRParent",
}
addBlock(HParent)

let BParent = 
{
	name:"BParent",
	x:220,
	y:0,
	width:180,
	height:280,
	type:RECT,
	debug:false,
	parent:"HBRParent",
}
addBlock(BParent)

let RParent = 
{
	name:"RParent",
	x:420,
	y:0,
	width:180,
	height:280,
	type:RECT,
	debug:false,
	parent:"HBRParent",
}
addBlock(RParent)




let H =
{
    name:"H",
    type:PATH,
    strokeWidth:4,

	point0: {x:102, y:0},
	point1: {x:102, y:128.16},
	point2: {x:86.09, y:128.16},
	point3: {x:86.09, y:72.74},
	point4: {x:16.08, y:72.74},
	point5: {x:16.08, y:128.16},
	point6: {x:0.17, y:128.16},
	point7: {x:0.17, y:0},
	point8: {x:16.08, y:0},
	point9: {x:16.08, y:58.35},
	point10: {x:86.09, y:58.35},
	point11: {x:86.09, y:0},
	point12: {x:102, y:0},

	scalePath:2.0,
    strokeColor:strokemain,
    fillColor:fillmain,
    debug:false,
	animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
	waitStartSeconds:time4,
	waitEndSeconds:time4 + time4duration,
	parent:"HParent",
}
addBlock(H)





let B =
{
    name:"B",
    type:BEZIER,
    strokeWidth:4,

	point0: {x:50.38, y:0},
	point1: { point:{x:73.84, y:4.31}, controlPoint1: {x: 59.54, y: 0}, controlPoint2: {x: 67.36, y: 1.44}},
	point2: { point:{x:88.78, y:16.65}, controlPoint1: {x: 80.32, y: 7.18}, controlPoint2: {x: 85.3, y: 11.29}},
	point3: { point:{x:94, y:35.97}, controlPoint1: {x: 92.26, y: 22.01}, controlPoint2: {x: 94, y: 28.45}},
	point4: { point:{x:90.48, y:51.11}, controlPoint1: {x: 94, y: 41.65}, controlPoint2: {x: 92.83, y: 46.7}},
	point5: { point:{x:80.53, y:61.9}, controlPoint1: {x: 88.13, y: 55.52}, controlPoint2: {x: 84.81, y: 59.12}},
	point6: { point:{x:65.28, y:67.14}, controlPoint1: {x: 76.25, y: 64.69}, controlPoint2: {x: 71.17, y: 66.43}},
	point7: {x:65.28, y:68.56},
	point8: { point:{x:76.52, y:73.72}, controlPoint1: {x: 69.44, y: 69.33}, controlPoint2: {x: 73.19, y: 71.05}},
	point9: { point:{x:84.5, y:83.62}, controlPoint1: {x: 79.85, y: 76.38}, controlPoint2: {x: 82.51, y: 79.68}},
	point10: { point:{x:87.49, y:96.19}, controlPoint1: {x: 86.49, y: 87.56}, controlPoint2: {x: 87.49, y: 91.75}},
	point11: { point:{x:82.9, y:113.19}, controlPoint1: {x: 87.49, y: 102.76}, controlPoint2: {x: 85.96, y: 108.43}},
	point12: { point:{x:69.78, y:124.25}, controlPoint1: {x: 79.83, y: 117.96}, controlPoint2: {x: 75.46, y: 121.65}},
	point13: { point:{x:49.4, y:128.16}, controlPoint1: {x: 64.11, y: 126.86}, controlPoint2: {x: 57.31, y: 128.16}},
	point14: {x:0.17, y:128.16},
	point15: {x:0.17, y:0},
	point16: {x:50.38, y:0},
	point17: {cmd:"close"},
	point18: {x:16.22, y:114.04},
	point19: {x:46.01, y:114.04},
	point20: { point:{x:64.61, y:108.62}, controlPoint1: {x: 53.98, y: 114.04}, controlPoint2: {x: 60.18, y: 112.23}},
	point21: { point:{x:71.26, y:93.43}, controlPoint1: {x: 69.04, y: 105.01}, controlPoint2: {x: 71.26, y: 99.95}},
	point22: { point:{x:63.9, y:78.07}, controlPoint1: {x: 71.26, y: 86.62}, controlPoint2: {x: 68.8, y: 81.5}},
	point23: { point:{x:41.91, y:72.92}, controlPoint1: {x: 58.99, y: 74.63}, controlPoint2: {x: 51.66, y: 72.92}},
	point24: {x:16.22, y:72.92},
	point25: {x:16.22, y:114.04},
	point26: {cmd:"close"},
	point27: {x:16.22, y:14.12},
	point28: {x:16.22, y:59.15},
	point29: {x:46.46, y:59.15},
	point30: { point:{x:69.69, y:53.51}, controlPoint1: {x: 56.75, y: 59.15}, controlPoint2: {x: 64.49, y: 57.27}},
	point31: { point:{x:77.5, y:36.77}, controlPoint1: {x: 74.9, y: 49.75}, controlPoint2: {x: 77.5, y: 44.17}},
	point32: { point:{x:70.01, y:19.89}, controlPoint1: {x: 77.5, y: 29.37}, controlPoint2: {x: 75, y: 23.74}},
	point33: { point:{x:47.98, y:14.12}, controlPoint1: {x: 65.01, y: 16.05}, controlPoint2: {x: 57.67, y: 14.12}},
	point34: {x:16.22, y:14.12},
	point35: {cmd:"close"},

	scalePath:2.0,
    strokeColor:strokemain,
    fillColor:fillmain,
    debug:false,
    animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
	waitStartSeconds:time4,
	waitEndSeconds:time4 + time4duration,
	parent:"BParent",
}
addBlock(B)



let R =
{
    name:"R",
    type:BEZIER,
    strokeWidth:4,

	point0: {x:16.18, y:113.95},
	point1: {x:47.04, y:113.95},
	point2: { point:{x:66.52, y:107.47}, controlPoint1: {x: 55.34, y: 113.95}, controlPoint2: {x: 61.83, y: 111.79}},
	point3: { point:{x:73.54, y:89.44}, controlPoint1: {x: 71.2, y: 103.14}, controlPoint2: {x: 73.54, y: 97.13}},
	point4: { point:{x:66.83, y:71.27}, controlPoint1: {x: 73.54, y: 81.56}, controlPoint2: {x: 71.31, y: 75.51}},
	point5: { point:{x:47.75, y:64.92}, controlPoint1: {x: 62.35, y: 67.04}, controlPoint2: {x: 55.99, y: 64.92}},
	point6: {x:16.18, y:64.92},
	point7: {x:16.18, y:113.95},
	point8: {cmd:"close"},
	point9: {x:16.18, y:50.71},
	point10: {x:47.75, y:50.71},
	point11: {x:47.75, y:50.71},
	point12: {x:47.75, y:50.71},
	point13: {x:75.23, y:0},
	point14: {x:94, y:0},
	point15: {x:64.29, y:53.2},
	point16: { point:{x:83.24, y:66.79}, controlPoint1: {x: 72.36, y: 55.75}, controlPoint2: {x: 78.67, y: 60.28}},
	point17: { point:{x:90.09, y:89.97}, controlPoint1: {x: 87.8, y: 73.3}, controlPoint2: {x: 90.09, y: 81.03}},
	point18: { point:{x:85.02, y:110.09}, controlPoint1: {x: 90.09, y: 97.67}, controlPoint2: {x: 88.4, y: 104.37}},
	point19: { point:{x:70.74, y:123.41}, controlPoint1: {x: 81.64, y: 115.8}, controlPoint2: {x: 76.88, y: 120.24}},
	point20: { point:{x:49.17, y:128.16}, controlPoint1: {x: 64.61, y: 126.58}, controlPoint2: {x: 57.42, y: 128.16}},
	point21: {x:0.17, y:128.16},
	point22: {x:0.17, y:0},
	point23: {x:16.18, y:0},
	point24: {x:16.18, y:50.71},

	scalePath:2.0,
    strokeColor:strokemain,
    fillColor:fillmain,
    debug:false,
    animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
	waitStartSeconds:time4,
	waitEndSeconds:time4 + time4duration,
	parent:"RParent",
}
addBlock(R)


for (x = 0; x < layoutx; x++)
{
	for (y = 0; y < layouty; y++)
	{
		let r = Math.random()
		let g = Math.random()
		let b = Math.random()
		let a = Math.random() + .3
		let rancolor  = { red:r, green:g, blue:b, alpha:a}

		let name = "text2022".concat(x.toString().concat(y.toString()))
        let  text =
		{
			type:TEXT,
			layoutSpec:{x:x,y:y,fit:true},
			name:name,
			text:"2022",
			size:95,
			center:true,
			textColor:rancolor,
			font:MainFont,
			waitStartSeconds:time5,
			waitEndSeconds:time5 + time5duration,
            animation0:{property:"transform.rotation.y",from:0,to:6,duration:4.0,autoReverses:true},
			animation1:{property:"opacity",from:.3,to:1,duration:2,autoReverses:true},
		}
		addBlock(text)
	}
}


for (x = 0; x < layoutx; x++)
{
	for (y = 0; y < layouty; y++)
	{
		let name = "grid".concat(x.toString().concat(y.toString()))
		let  grid =
		{
			type:GRID,
			layoutSpec:{x:x,y:y,fit:true},
			name:name,
			xspacing:10,
			yspacing:10,
			width: 150,
			height:150,
			center:true,
			gridColor:green,
			waitStartSeconds:time6,
			waitEndSeconds:time6 + time6duration,
            childBlock0: {type:TEXT,name:"title",text:"HBR",size:55,center:true,textColor:red,font:MainFont,animation0:{property:"transform.rotation.z",from:0,to:360,duration:Math.random(40),autoReverses:true}},
		}
		addBlock(grid)
	}
}

let countdown = 
{
    name:"countdown",
    type:NUMBER,
    number: 3.0,
	layoutSpec:{x:2,y:2,fit:true},
	center:true,
    format:"Pausing: %1.1f Seconds",
    increment: -0.1,
    incrementSeconds: 0.1,
    fillGradient:blockbackgrad,
    strokeColor:green,
    strokeWidth:5,
    radius:4,
    textColor:white,
    font:"Courier",
    padding:45,
	waitStartSeconds:time7,
	waitEndSeconds:time7 + time7duration,
	animation0:{property:"position",move:{x:40,y:40},duration:time7duration,autoReverses:false},
}

addBlock(countdown)


let happy = 
{
	type:TEXT,
	layoutSpec:{x:2,y:2,fit:true},
	name:"happy",
	text:"HAPPY BIRTHDAY",
	size:200,
	center:true,
	textColor:red,
	font:"Futura",
	waitStartSeconds:time8,
	waitEndSeconds:time8 + time8duration,
}
addBlock(happy)

let person = 
{
	type:TEXT,
	layoutSpec:{x:2,y:1,fit:true},
	name:"person",
	text:"REYN",
	size:200,
	center:true,
	textColor:blue,
	font:"Futura",
	waitStartSeconds:time8,
	waitEndSeconds:time8 + time8duration,
	animation0:{property:"opacity",from:1.0,to:0.0,duration:5,autoReverses:false},

}
addBlock(person)



