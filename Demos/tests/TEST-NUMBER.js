includeFile("../Constants")
includeFile("../BasicScreen")

let block =
{
	name:"block",
	type:NUMBER,
	number: 10.50,
	x:100,
	y:100,
	format:"Fuel: %2.2f MegaGals",
	increment: -.05,
	incrementSeconds: 0.5,
	fillGradient:blockbackgrad,
    strokeColor:green,
    strokeWidth:5,
    radius:4,
	textColor:white,
	font:"Courier",
	padding:15,
}
addBlock(block)

let block2 =
{
	name:"block2",
	type:NUMBER,
	number: 20000.50,
	x:100,
	y:160,
	format:"Speed: %2.2f Parsecs per Hour",
	increment: .50,
	incrementSeconds: 0.01,
	fillGradient:blockbackgrad,
    strokeColor:green,
    strokeWidth:5,
    radius:4,
	textColor:white,
	font:"Courier",
	padding:15,
	clip:true,
}
addBlock(block2)

let countdown =
{
    name:"countdown",
    type:NUMBER,
    number: 10.0,
	x:100,
	y:220,
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
	waitStartSeconds:2.0,
    waitEndSeconds:2.0 + 10.0,
}

addBlock(countdown)


let happy =
{
    type:TEXT,
	x:100,
	y:320,
    name:"happy",
    text:"HAPPY BIRTHDAY",
    size:180,
    center:true,
    textColor:red,
    font:"Futura",
    waitStartSeconds:3,
    waitEndSeconds: 10,
    animation1:{property:"opacity",from:0.0,to:1.0,duration:10,autoReverses:false},

}
addBlock(happy)

let person =
{
    type:TEXT,
	x:100,
	y:220,
    name:"person",
    text:"REYN",
    size:180,
    center:true,
    textColor:blue,
    font:"Futura",
    waitStartSeconds:3,
    waitEndSeconds: 10,
    animation1:{property:"opacity",from:0.0,to:1.0,duration:10,autoReverses:false},

}
addBlock(person)
