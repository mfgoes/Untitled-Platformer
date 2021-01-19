 /// @description Insert description here
#region //Debug Mode
//gm live 
//if (live_call()) return live_result; 

if (debugmode) &&  keyboard_check_pressed(ord("P")) {	//check if in debug mode
	if current_character = 2 current_character = 0;
	else 
	current_character +=1;
	y-=15; //prevents clamming to gorund

	Load_CharacterData(current_character)
	//Sprites
	spriteIdle =	current_character_sprites[0] 
	spriteWalk =	current_character_sprites[1]
	spriteRoll =	current_character_sprites[2]
	spriteJump =	current_character_sprites[3]
	spriteDie  =	current_character_sprites[4]
	spriteAim  =	current_character_sprites[6]
	mask_index =	current_character_sprites[5]; //be more specific later; 

canrope = !canrope;	//toggle rope
audio_sound_gain(snClick,0.3,0);
audio_play_sound(snClick,5,0);
	
}
#endregion

//Player game input (KB / Mouse / Gamepad)
PlayerInput();

//Change player state
script_execute(state);	

//Collisions. Make more compact later + determine better when to call. 
PlayerCollision();
