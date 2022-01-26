includeFile("Constants")
includeFile("BasicScreen")

let dur = 0.4 
let rev = true

for (x = 1; x < 10; x++)
{
	let line2 = 
	{
		type:LINE,
		name:"line",
		x:0,
		y:0,
		endX:300 + (x * 10),
		endY:300 + (x * 30),
		strokeWidth:1,
		strokeColor:orange,
		lineCap:"round",
		debug:true,
		animation0:{property:"strokeStart",from:1.0,to:0.0,duration:dur,autoReverses:rev},
		animation1:{property:"position",move:{x:100,y:100},duration:dur,autoReverses:rev},
	}
	addBlock(line2)
}

