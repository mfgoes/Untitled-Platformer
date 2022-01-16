/// @description Control Menu
if (live_call()) return live_result; 

y = oPlayer.y;

//Keyboard Controls
if (menu_control) 
{
	//restart game
	if keyboard_check_released(ord("R"))
	SlideTransition(TRANS_MODE.RESTART);
	
	//key controls (are easier to setup)
	if (keyboard_check_pressed(vk_down))
	{
		menu_move++;
		if (menu_move >= menu_index) menu_move = 0;
	}
		
	if (keyboard_check_pressed(vk_up))
	{
		menu_move--;
		if (menu_move <0) menu_move = menu_index-1;
	}
	
	#region determine mouse position on menu (new)
		var mouse_y_gui = (device_mouse_y_to_gui(0)); 
		
		if (mouse_y_gui < menu_y_bot) && (mouse_y_gui > menu_y_top) { //can also use clamp function
			menu_move = (mouse_y_gui - menu_y_top) div (line_height/resolution);	
		} else exit;
	
		
		//determine top and bottom limits
		//if menu_move >= menu_index {menu_move = 0;}
		//if menu_move < 0 {menu_move = menu_index-1;}
		
		
		//set new menu_move position 
		
		/*
		//gg = RES_H + 120 - (line_height * i);
		//menu_y =  (RES_H + 120) *2; 
		var mouse_y_gui = (device_mouse_y(0)) * 2 //80 = 120 - line_height
		if (mouse_y_gui < menu_y) && (mouse_y_gui > menu_top) 
		{
		menu_move =  (menu_y - mouse_y_gui) div (menu_item_height * gui_mult);
		//	menu_move = (menu_y - mouse_y_gui) div (menu_item_height * gui_mult);
		}*/

	#endregion
if (mouse_check_button_pressed(mb_left)) || (keyboard_check_pressed(vk_enter))
	{
		menu_x_target = gui_width+20;
		menu_committed = menu_move;
		audio_sound_gain(snJump1,0.2,0);
		audio_play_sound(snJump1,5,0);
		//ScreenShake(4,10);
		menu_control = false;		
	}
}

//menu_committed = menu_move;
if (menu_committed != -1) //&& (menu_x > gui_width+150) 
{
	switch (menu_committed)
	{
		case 0: //continue
			instance_destroy();
			/*with all
			{
				image_speed = image_speed_previous;
			}*/
			global.game_paused = false;
			display_set_gui_size(RES_W, RES_H);
			break
		case 1: //sound settings
			instance_destroy();
			with oGame pause_menu = instance_create_layer(0, 0, "Player", oSettingsMenu);
			break;
		case 2: //controls
			instance_destroy();
			with oGame pause_menu = instance_create_layer(0, 0, "Player", oControlsMenu);
			break
		case 3: //credits
			instance_destroy();
			with oGame pause_menu = instance_create_layer(0, 0, "Player", oCreditsMenu);
			break
		case 4: //start screen
			instance_destroy(oGame);
			instance_destroy(oCamera);
			display_set_gui_size(RES_W, RES_H);
			room_goto(rMenu);
		break;
		case 5: //quit game
			game_end(); break;
		
	}
}

///GUI items ease in
//menu_x +=(menu_x_target - menu_x) / menu_speed;
