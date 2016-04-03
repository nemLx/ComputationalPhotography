var pan_imgs = new Array();
pan_imgs[0] = './img/unionCourt/unionCourtCropped.jpg';
pan_imgs[1] = './img/sbAtrium/sbAtriumCropped.jpg';
pan_imgs[2] = './img/myStudy/myStudyCropped.jpg';

function Pan(imName, id) {
	
	this.imName = imName;
	this.id = id;
	
	this.hScale = 1;
	this.vScale = 1;
	this.srcHeight = 1;
	this.srcWidth = 1;
	this.clipStartX = 0;
	this.pointerOffset = 0;
	this.delta = 0;
	this.resolution = 2000;
	this.viewAngle = 150;
	this.sliceWidth = 0;
	
	this.canvas = document.getElementById(id);
	this.context = this.canvas.getContext("2d");
	
	this.img = document.createElement('img');
	this.img.src = imName;
	this.img.onload = updateImage(this);
	
	var self = this;
	
	this.move = function(e){
		var pageX = e.pageX;
		drag(self, pageX);
	}
	
	this.startDrag = function(e){
		self.pointerOffset = e.pageX;
		pan_addEventListener(self.canvas, 'mousemove', self.move)
	}
	
	this.endDrag = function(e){
		pan_removeEventListener(self.canvas, 'mousemove', self.move)
	}
	
	this.mouseWheel = function(e){
		if ('wheelDelta' in e){
			d = e.wheelDelta;
		}else{
			d = -40*e.detail;
		}
		
		zoom(self, d);
	}
	
	pan_addEventListener(this.canvas, 'mousedown', this.startDrag);
	pan_addEventListener(this.canvas, 'mouseup', this.endDrag);
	pan_addEventListener(this.canvas, 'mousewheel', this.mouseWheel);
	pan_addEventListener(this.canvas, 'DOMMouseScroll', this.mouseWheel);
	pan_addEventListener(document.body, 'mousewheel', disableMouseWheel);
	pan_addEventListener(document.body, 'DOMMouseScroll', disableMouseWheel);
}



function pan_addEventListener(elem, event, fcn){
	
	if (elem.addEventListener){
		elem.addEventListener(event, fcn, false);
	}else{
		elem.attachEvent('on'+event, fcn);
	}
}



function pan_removeEventListener(elem, event, fcn){
	
	if (elem.addEventListener){
		elem.removeEventListener(event, fcn, false);
	}else{
		elem.detachEvent('on'+event, fcn);
	}
}



function disableMouseWheel (e){
	var tClass = e.target.className;
	if(tClass.match('pan')){
		e.preventDefault(); 
		e.stopImmediatePropagation();
	}
}



function updateImage(p){
	p.srcHeight = p.img.height;
	p.srcWidth = p.img.width;
	refreshCanvas(p);
}



function init(i, id){
	new Pan(pan_imgs[i], id);
}



function refreshCanvas(p){
	updateSizes(p);
	
	var destStartX = 0.0;
	p.clipStartX = updateClipStartX(p);
		
	for (i=0; i<p.resolution; i++) {
		destStartX = drawSlice(p, i, destStartX);
	}
}



function drawSlice(p, i, destStartX){
	var angle = computeSliceAngle(p, i);
	var projectedWidth = p.hScale*p.sliceWidth;
	
	var sx = computeSX(p, i);
	var sy = 0;
	
	var sw = p.sliceWidth;
	var sh = p.srcHeight;
	
	var dw = projectedWidth+1;
	var dh = p.vScale*p.srcHeight*cosec(angle);
	
	var dx = destStartX;
	var dy = (p.canvas.height - dh)/2;
	
	p.context.drawImage(p.img, sx, sy, sw, sh, dx, dy, dw, dh);
	
	return destStartX + projectedWidth;
}



function updateSizes(p){
	p.canvas.width = 930;
	p.canvas.height = p.canvas.width*0.60;
	
	p.hScale = p.canvas.width/((p.srcWidth*p.viewAngle)/(360));
	p.vScale = p.canvas.height/(p.srcHeight*cosec(computeSliceAngle(p, 1)));
	
	p.sliceWidth = (p.srcWidth/360.0)*(p.viewAngle/p.resolution);
}



function computeSX(p, i){
	sx = p.clipStartX + i*p.sliceWidth;
	if (sx + p.sliceWidth > p.srcWidth){
		sx -= (p.srcWidth - p.sliceWidth);
	}
	return sx;
}



function computeSliceAngle(p, i){
	var flatAngle = 360*p.canvas.width/(p.srcWidth);
	var newView = Math.abs(flatAngle/2 - p.viewAngle)
	var t = newView/2-i*newView/p.resolution;
	return Math.min(90-t, 90+t);
}



function cosec(deg){
	return 1/Math.sin(deg*(Math.PI/180));
}



function updateClipStartX(p){
	var x = p.clipStartX + p.delta/p.hScale;
	
	if (x > p.srcWidth){
		x-= p.srcWidth;
	}	
	if (x < 0){
		x+= p.srcWidth;
	}
	
	return x;
}



function zoom(p, d){
	var flatAngle = 360*p.canvas.width/(p.srcWidth);
	
	if (d > 0 && p.viewAngle > flatAngle){
		p.viewAngle = p.viewAngle-10;
	}else if (d < 0 && p.viewAngle < 180){
		p.viewAngle = p.viewAngle+10;
	}
	
	refreshCanvas(p);
}



function drag(p, px){
	p.delta = p.pointerOffset - px;
	p.pointerOffset = px;
	refreshCanvas(p);
}


