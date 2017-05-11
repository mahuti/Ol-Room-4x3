//
// Ol Room 4x3
// Theme by Mahuti
// vs. 1.0
//

class UserConfig {
	</ label="Selected System", help="Selecting auto will allow you to use this one theme folder for multiple systems (you must name your lists to match the system folders listed in this theme). Selecting a specific system name is useful if you are using multiple copies of this theme to handle different systems. ", order=1, options="auto, Atari 2600, Intellivision, Nintendo 64, Nintendo NES, Nintendo SNES, ScummVM, Sega Genesis, Sony Playstation, Generic TV, Generic PC" /> selected_system="auto"; 

 	</ label="Game Titles", help="Select game title style", order=2, options="show wheel images, text titles, no titles" /> game_titles="show wheel images";
	</ label="Show Playtime", help="Show game playtime", order=3, options="yes, no" /> show_playtime="no"; 
	
	</ label="Cartridge Folder", help="Choose folder that stores Cartridge art. Not all consoles use cartridge art.", order=4, options="cartridge, marquee, none" /> cartridge_folder="marquee"; 
	</ label="Boxart Folder", help="Choose folder that stores Boxart Images", order=5, options="boxart, flyer, none" /> boxart_folder = "flyer"; 
	
	</ label="Boxart Shadows", help="Show shadows underneath boxart", order=6, options="yes, no" /> boxart_shadows="yes"; 
	
}
 
  
local config = fe.get_config();


// layout was built in photoshop. all numbers in this used are based off of the photoshop file's size. 
local base_width = 1440.0; // make sure this number is followed by .0 to make it a float. 
local base_height = 1080.0; // see note above. 

// width conversion factor
local xconv = fe.layout.width / base_width; 
// height conversion factor
local yconv = fe.layout.height / base_height; 


// get a width value converted using conversion factor
function width( num )
{
    return  num * xconv; 
}
// get a height value converted using conversion factor
function height( num )
{
	return num * yconv; 
}
// get a x position converted using conversion factor
function xpos( num )
{
    return num * xconv; 
}
// get the y position value converted using conversion factor
function ypos( num )
{
	return num * yconv; 
}
// debug text to tty
function debug( text )
{
    print( "Debug: " + text + "\n" );
    return true;
}
function dirty_debug( text )
{
	local debug_text = fe.add_text(text, xpos(16), ypos(1023), width(700),height(39));
	debug_text.align = Align.Left;
	debug_text.charsize = 20;
	debug_text.set_rgb(255, 255, 255);
 	
}

local console = fe.list.name; 

if (config["selected_system"] != "auto")
{
	console = config["selected_system"]; 
} 

fe.add_transition_callback(this, "on_transition"); 
function on_transition(ttype, var, ttime) {
	
	local last_console = console; 
	
	if (config["selected_system"] != "auto")
	{
		console = config["selected_system"]; 
	}
	else
	{
		console = fe.list.name;
	}
	
	switch( ttype)
	{
		case Transition.ToNewList:
		//console = fe.list.name;
		if (last_console != console)
		{
			fe.signal("reload"); 
		}
		break;
		default: 
  	}
   return false;
}

 
 
function set_titles( unused )
{
	// Title
	local title = fe.add_text("[Title]", xpos(18), ypos(18), width(317), height(32));
 	title.charsize = 24;
	title.set_rgb(247, 35, 0);
	title.font =  console + "/" + "font"; 
} 
 
//Background
local bg = fe.add_image(console + "/" + "bg.jpg", 0,0, width(1440), height(1080) );


local snap_x = 361;
local snap_y = 153; 
local snap_w = 610; 
local snap_h = 460; 

local cart_width=263; 
local cart_height=50;
local cart_x = 69;
local cart_y = 739; 
local cart_pinch_x = 0;
local cart_pinch_y = 0;  
local cart_preserve_aspect_ratio = true; 
local boxart_x = 1109; 
local boxart_y = 527; 
local boxart_width = 281; 
local boxart_height = 396; 

local wheel_x = 984; 
local wheel_y = 941; 
local wheel_width = 336; 
local wheel_height = 127; 


switch (console)
{
	case "Atari 2600":
		cart_pinch_x = -3;
		cart_width=173;
		cart_height=30; 
		cart_x = 78;
		cart_y = 557; 
		cart_preserve_aspect_ratio =  false; 
		
		boxart_x = 1017; 
		boxart_y = 548; 
		boxart_width = 281; 
		boxart_height = 396; 
		
 		break;
	
	case "Sega Genesis":
		cart_width=239; 
		cart_height=135;
		cart_x = 194;
		cart_y = 562; 
		wheel_x = 1068; 
		break; 
		
	case "Intellivision":
		break; 
		
	case "Nintendo NES":
		cart_width=263; 
		cart_height=50;
		cart_x = 69;
		cart_y = 739;
		
		boxart_x = 1008; 
		boxart_y = 527; 
		boxart_width = 281; 
		boxart_height = 396; 
		
		break;
		
	case "Nintendo SNES":
		cart_width=307; 
		cart_height=290;
		cart_x = 68;
		cart_y = 498; 
		
		boxart_x = 1004; 
		boxart_y = 603; 
		boxart_width = 393; 
		boxart_height = 287; 
		
		break;
		
	case "Nintendo 64":
		cart_width=278; 
		cart_height=182;
		cart_x = 45;
		cart_y = 502; 
	
		boxart_x = 1011; 
		boxart_y = 602; 
		boxart_width = 391; 
		boxart_height = 309; 
		
		break;
	case "Sony Playstation":
		cart_width=278; 
		cart_height=182;
		cart_x = 45;
		cart_y = 502; 

		boxart_x = 1011; 
		boxart_y = 602; 
		boxart_width = 391; 
		boxart_height = 309; 
	
		break;
	case "ScummVM":
		snap_x = 460;
		snap_y = 105; 
		snap_w = 610; 
		snap_h = 460; 
		
		boxart_x = 30; 
		boxart_y = 532; 
		
		wheel_x = 1020; 
		wheel_y = 951; 
		
		break; 
	default:
		
} 


///////////////////////////////////////////////////////
// 					BOXART
///////////////////////////////////////////////////////

if (config["boxart_folder"] !="none")
{
	if (config["boxart_shadows"] == "yes")
	{
		local box_shadow = fe.add_image(console + "/" + "box_shadow.png", 0,0, width(1440), height(1080) );
		box_shadow.preserve_aspect_ratio = true;
	}

	local boxart = fe.add_artwork(config["boxart_folder"], xpos(boxart_x), ypos(boxart_y), width(boxart_width), height(boxart_height));
	boxart.preserve_aspect_ratio = false;
	boxart.trigger = Transition.EndNavigation;
}


///////////////////////////////////////////////////////
// 					WHEEL LOGO / TITLES
///////////////////////////////////////////////////////

if ( config["game_titles"] == "show wheel images" )
{
 	// wheel
	local wheel = fe.add_artwork("wheel", xpos(wheel_x), ypos(wheel_y), width(wheel_width), height(wheel_height));
	wheel.preserve_aspect_ratio = true;
	wheel.trigger = Transition.EndNavigation;
	
}
if (config["game_titles"] =="text titles"){
	// Title
	local title = fe.add_text("[Title]", xpos(1067), ypos(978), width(244), height(181));
	title.align = Align.Right;
	title.charsize = 24;
	title.set_rgb(247, 35, 0);
	title.font =  console + "/" + "font"; 
} 
 
 
 
///////////////////////////////////////////////////////
// 					PLAY TIME
///////////////////////////////////////////////////////
 
if (config["show_playtime"] == "yes")
{
	// Playtime
	local playtime = fe.add_text("[System] Playcount:[PlayedCount] Time:[PlayedTime]", xpos(16), ypos(993), width(700),height(39));
	playtime.align = Align.Left;
	playtime.charsize = 20;
	playtime.set_rgb(255, 255, 255);
}

///////////////////////////////////////////////////////
// 					SNAP & SNAP OVERLAYS
///////////////////////////////////////////////////////

local snap = fe.add_artwork("snap", xpos(snap_x), ypos(snap_y), width(snap_w), height(snap_h));
snap.trigger = Transition.EndNavigation;

if (console != "scummvm")
{
	// Scanlines
	local scanlines = fe.add_image("scanlines.png", xpos(snap_x), ypos(snap_y), width(snap_w), height(snap_h));
	scanlines.preserve_aspect_ratio = false;
	scanlines.alpha = 130;

	// TV Borders
	local borders = fe.add_image("borders.png", xpos(snap_x), ypos(snap_y), width(snap_w), height(snap_h));
	borders.preserve_aspect_ratio = false;
}

///////////////////////////////////////////////////////
// 					CARTRIDGES
///////////////////////////////////////////////////////

if (config["cartridge_folder"] !="none")
{
	local cartridge = fe.add_artwork(config["cartridge_folder"], xpos(cart_x), ypos(cart_y), width(cart_width), height(cart_height));
	cartridge.preserve_aspect_ratio = true;

	if (cart_preserve_aspect_ratio == false)
	{
		cartridge.preserve_aspect_ratio = false;
		
	}
	if (cart_pinch_x != 0)
	{
		cartridge.pinch_x = cart_pinch_x; 
	}
	if (cart_pinch_y != 0)
	{
		cartridge.pinch_y = cart_pinch_y; 
	}
	cartridge.trigger = Transition.EndNavigation;
}



///////////////////////////////////////////////////////
// 			IMAGE OVERLAYS / CART MASKS
///////////////////////////////////////////////////////

local overlay = fe.add_image(console + "/"+"foreground.png", 0, 0, width(1440), height(1080));
overlay.preserve_aspect_ratio = true;
 

 
///////////////////////////////////////////////////////
// 					UNUSED
///////////////////////////////////////////////////////
 
/*
fe.load_module("file"); 
function file_exists( fullpathfilename )
{
	try{ file(fullpathfilename, "r"); return true;} catch(e){return false;}
}

local fullpathfilename = console + "/" + "box_shadow.png"; 

if (file_exists(fullpathfilename))
{
	local flyer_shadow = fe.add_image(console + "/" + "box_shadow.png", 0,0, width(1440), height(1080) );
	flyer_shadow.preserve_aspect_ratio = true;
}
*/