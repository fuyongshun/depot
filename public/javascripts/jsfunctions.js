function move_to(num) {	
	set_cookie_value("menu_number", "" + num);
    	var posx = parseInt(nonius.style.left);
    	var number = parseInt(num);
    	var objleft = 11 + number * 63;
    	if(objleft != posx){
    		var fac = objleft>posx?21:-21;
    		function move(){
    			posx += fac;
    			nonius.style.left = posx + "px";	
    			nonius_text.style.left = -(posx - 11) + "px";
    			if(posx == objleft){
    				clearInterval(ind);
    			}							
    		}
    		var ind = setInterval(move, 20);
   	}
}


function show_personal_space(){
	var speed = 20;
	var width = 26;
	var final_width = 306;

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
	set_cookie_value("personal_space", "true");
}

function hide_personal_space(){
	var speed = 20;
	var width = 306;
	var final_width = 26;

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
	set_cookie_value("personal_space", "false");
}

function set_cookie_value(attribute_name, value){
	document.cookie=attribute_name + "=" + escape(value);
}

function get_cookie_value(attribute_name){
	if (document.cookie.length>0){
		c_start=document.cookie.indexOf(attribute_name + "=");
		if (c_start!=-1){ 
			c_start=c_start + attribute_name.length+1 ;
			c_end=document.cookie.indexOf(";",c_start);
			if (c_end==-1) c_end=document.cookie.length
				return unescape(document.cookie.substring(c_start,c_end));
		} 
	}
	return "";
}

function link_to(address, button_type, button_name){
	var str = "<a href = '" + address + "' class = '" + button_type;
	str += "' onclick = \"set_menu_button(\'" + button_name + "\')\" "
	str += "unselectable='on' onselectstart='return false'>";
	document.write(str);
}

/*function set_menu_button(menu_button){
	set_cookie_value("menu_button", menu_button);
	//var menu_button_home = document.getElementById("menu_button_" + menu_button);
	//menu_button_home.className = "disable_menu_button";
}*/


function clear_menu_button(){
	old_menu_button.className = "menu_button";
}

function set_menu_button(menu_button_name){
	old_menu_button.className = "menu_button";
	var menu_button = document.getElementById("menu_button_" + menu_button_name);
	menu_button.className = "disable_menu_button";
	old_menu_button = menu_button;
}

function set_page_location(location){
	set_cookie_value("page_location", "location");
	var page_location = document.getElementById("page_location");
	page_location.innerHTML = location;
}




