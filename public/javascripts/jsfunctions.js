function move_to(num) {	
    	var posx = parseInt(nonius.style.left);
    	var number = parseInt(num);
    	    		var objleft = 11 + number * 63;
    	if(objleft != posx){
    		var fac = objleft>posx?21:-21;
    		function move(){
    			posx += fac;
    			nonius.style.left = posx + "px";	
    			if(posx == objleft){
    				clearInterval(ind);
    			}							
    		}
    		var ind = setInterval(move, 20);
   	}
}


function show_personal_space(){
	var speed = 20;
	var width = 25;
	var final_width = 305;

	function move_to_right(){
		width += speed;
		personal.style.width = width + "px";
		if(width >= final_width){
			clearInterval(ind);
		}
	}
	var ind = setInterval(move_to_right, 20);
	show_button.hide();
	hide_button.show();
}

function hide_personal_space(){
	var speed = 20;
	var width = 305;
	var final_width = 25;

	function move_to_right(){
		width -= speed;
		personal.style.width = width + "px";
		if(width <= final_width){
			clearInterval(ind);
		}
	}
	var ind = setInterval(move_to_right, 20);
	hide_button.hide();
	show_button.show();
}
