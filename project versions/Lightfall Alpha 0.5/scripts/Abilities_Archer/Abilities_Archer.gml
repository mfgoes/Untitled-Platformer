///ABILITIES

/*
Cleaned up in 2022.4. 
*/

function Ability_Primary_Archer() {
	
	var key_attack_pressed		= oPlayer.key_primary;
	var key_attack_released		= oPlayer.key_attack_released;
	var cooldown = 25;
	
	if (key_attack_pressed) &&  timer_get("primary_cooldown") = -1 {		
		if (!place_meeting(x,y+1,oWall)) && (!place_meeting(x,y+1,oParPlatform)) oPlayer.air_shot = true;

		//charging sound
		if weapon_charge = 0 {
			audio_sound_gain(snPrepareBow,0.1,0);
			audio_play_sound(snPrepareBow,0,0);}
				
		timer_set("weapon_display",120); 
		if (weapon_charge < weapon_charge_max) 
			weapon_charge+=0.25;
		else if timer_get("poof_trail") <= 1 {
			dd = instance_create_depth(x+lengthdir_x(10,image_angle)+random_range(-2,2),y+lengthdir_y(10,image_angle)+random_range(-3,3),depth-1,oDust); 
			dd.hsp = 0; dd.vsp = 0; if random(1)<0.4 dd.col_start = c_orange; dd.image_alpha = 0.8; 
			timer_set("poof_trail",10);
		}
	}
	else {	
		oPlayer.air_shot = false;
	}
			
	if (key_attack_released) && timer_get("primary_cooldown") = -1  //for bow weapons
	{
		timer_set("primary_cooldown",cooldown);
		oUIElements.primary_cooldown  = cooldown; //for UI
		audio_sound_gain(snBlaster,0.35,0);
		audio_sound_pitch(snBlaster,choose(0.9,0.93,1));
		audio_play_sound(snBlaster,2,0);
				
		//create projectile
		with (instance_create_layer(x,y,"Bullets",oArrow)) { //with (instance_create_layer(x,y,"Bullets",oBullet)) {
			direction = other.image_angle;
					
			//variable damage
			if oPlayerWeapon.weapon_charge >= oPlayerWeapon.weapon_charge_max*0.8 {damage = 4; super_arrow = true; audio_sound_pitch(snDartGun2,1);}
			else if oPlayerWeapon.weapon_charge >= oPlayerWeapon.weapon_charge_max*0.45 {damage = 3;}
			else damage = 2;
					
			image_angle = direction;
			x = x - lengthdir_x(0,other.image_angle);
			y = y - lengthdir_y(0,other.image_angle);
		}			
		//reset weapon
		weapon_charge = 0; 
		//gun kickback
		gunkickx = lengthdir_x(-2,other.image_angle-180);
		gunkicky = lengthdir_y(-2,other.image_angle-180);
		weapon_recoil = 3;
		ScreenShake(2,1);
	}	
}

function Ability_Secondary_Archer() {
	var key_secondary = oPlayer.key_secondary;
	timer_init("triple_shot");
	
	if (key_secondary = true) && timer_get("secondary_cooldown") = -1 {
			timer_set("secondary_cooldown",secondary_cooldown); 
			oUIElements.secondary_cooldown  = 0; //for UI
			
			shots_total = 3; //shoot 3 bullets after each other
			timer_set("triple_shot",5);
			gunkickx = lengthdir_x(-2,other.image_angle-180);
			gunkicky = lengthdir_y(-2,other.image_angle-180);
			weapon_recoil = 3;
			timer_set("weapon_display",120); 
			ScreenShake(2,1);
			
		}
		
		
		if shots_total > 0 && timer_get("triple_shot") <=0 {
			timer_set("triple_shot",5);
			with (instance_create_layer(x,y,"Bullets",oArrow_Triple)) { //with (instance_create_layer(x,y,"Bullets",oBullet)) {
			direction = other.image_angle+random_range(-2,2); 
			spd = 7;
					
			image_angle = direction;
			x = x - lengthdir_x(0,other.image_angle);
			y = y - lengthdir_y(0,other.image_angle);
	
			//sound
			sound_shot = snBlaster; 
			audio_sound_gain(sound_shot,0.1,0); 
			audio_play_sound(sound_shot,2,0);
			}
			shots_total --;
		} else weapon_active = 0;
} 	

/// @function       Ability_Spread_Archer();
/// @desc			Calls a storm of arrows to rain down around the player
function Ability_Spread_Archer() { 
	if (oPlayer.key_special) && timer_get("special_cooldown") = -1 {
		timer_set("special_cooldown",third_cooldown);
		instance_create_depth(x,y,depth,oAttack_StormArrows);
		
		//sound
		sound_shot = huntress_R_rain_loop_01; 
		audio_sound_gain(sound_shot,0.3,0); 
		audio_play_sound(sound_shot,2,0);
		
		sound2 = mage_m1_cast_fire_v2_01; 
		audio_sound_gain(sound2,0.1,0); 
		audio_play_sound(sound2,1,0);
		
		
	}
} 	