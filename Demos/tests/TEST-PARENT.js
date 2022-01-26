includeFile("Constants")
includeFile("BasicScreen")


let bezblock =
{
	name:"bezblock",
	type:RECT,
	x:110,
	y:110,
	width:240,
	height:240,
	fillColor:black,
	strokeColor:orange,
	strokeWidth:2,
	radius:4,
	animation1:{property:"position",move:{x:200,y:200},duration:4.0,autoReverses:true},
}
addBlock(bezblock)

let B =
{
    name:"B",
	x:10,
	y:10,
    type:BEZIER,
    strokeWidth:2,
	strokeColor:green,
	fillColor:red,
	debug:false,
	animation0:{property:"strokeStart",from:1.0,to:0.0,duration:4.0,autoReverses:true},
	parent:"bezblock",
	
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
 
}
addBlock(B)

