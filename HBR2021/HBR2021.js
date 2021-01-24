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
