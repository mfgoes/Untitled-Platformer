 //general gravity
if global.game_paused {
	exit;
}

//parent timers
timer_init("notice_player"); //when to notice player
timer_init("ignore_player"); //when to ignore player
timer_init("turn_around");
timer_init("attack_player");
timer_init("freeze_anim"); 


//gravity
VerticalCollision(); 
grounded = (place_meeting(x,y+1,oWallParent) or place_meeting(x,y+1,oPlatformParent)); //was oWallParent

//destroy if outside room + fallen
if y > room_height {
	hp = 0;
}

#region animation flags 

	if freeze > 0 {
		image_speed = 0;
		freeze--;
	}
	else {
		
		//fix for freeze 
		if freeze != 0 freeze = 0;
		
		if hp <= 0 {
			//sprite_index = spriteDie;	
			hsp = 0; //prevents flipping
		}
		else if current_state = enemy_states.attack && timer_get("attack_reload") > 0 {
			sprite_index = spriteAttack;
		}
		else if current_state = enemy_states.approach {
			sprite_index = spriteWalk;
			image_speed = 1;
		}
		else if current_state = enemy_states.idle && hp > 0 {
			if hsp = 0
				sprite_index = spriteIdle;
			else
				sprite_index = spriteWalk;
			image_speed = 1;
		}
	}
#endregion