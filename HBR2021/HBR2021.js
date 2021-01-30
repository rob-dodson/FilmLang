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
		let name = "circle".concat(x.toString()).concat(y.toString())

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
    strokeWidth:4,
//	layoutSpec:{x:1,y:1,fit:true},

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
    type:PATH,
    strokeWidth:4,
//    layoutSpec:{x:2,y:1,fit:true},

point0:{x: 121.5, y: 161.5},
point1:{x: 121.5, y: 34.5},
point2:{x: 172.5, y: 34.5},
point3:{x: 190.5, y: 61.5},
point4:{x: 190.5, y: 83.5},
point5:{x: 172.5, y: 97.5},
point6:{x: 137.5, y: 100.5},
point7:{x: 172.5, y: 105.5},
point8:{x: 190.5, y: 116.5},
point9:{x: 190.5, y: 147.5},
point10:{x: 172.5, y: 161.5},
point11:{x: 121.5, y: 161.5},

	closePath:true,
    strokeColor:green,
    debug:false,
    animation0:{property:"strokeStart",from:1.0,to:0.0,duration:2.4,autoReverses:true},
}
addBlock(B)

