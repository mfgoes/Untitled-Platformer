/// @description Draw Score

//gm live 
if (live_call()) return live_result; 

//	put in script: DRAW PLAYER GUI*****

if (room != rMenu) && (instance_exists(oPlayer))
{
	//draw crosshair
	cursor_sprite = sCrosshairs; //make differnet cursor when in menus later
	//draw cooldowns for player	
	var cooldown_posx = RES_W-96;
	var cooldown_posy =  RES_H -35;
	var UIscale = 0.75; //set this to customizable variable later
	draw_set_alpha(1);
	draw_sprite_ext(sCooldowns_Archer,0,cooldown_posx+5,cooldown_posy,UIscale,UIscale,0,c_gray,1);
	draw_sprite_ext(sCooldowns_Archer,1,cooldown_posx+35,cooldown_posy,UIscale,UIscale,0,c_gray,1);
	draw_sprite_ext(sCooldowns_Archer,2,cooldown_posx+65,cooldown_posy,UIscale,UIscale,0,c_gray,1);
	draw_set_halign(fa_center);
	draw_text(cooldown_posx+17,cooldown_posy+4,oPlayer.primary_cooldown); 
	draw_text(cooldown_posx+47,cooldown_posy+4,oPlayer.secondary_cooldown); 
	draw_text(cooldown_posx+77,cooldown_posy+4,oPlayer.roll_cooldown); 
	
	
	//draw HP	
	var hp = oPlayer.hp; var hp_max = oPlayer.hp_max;
	var healthUImax = 100; 
	var healthUI = (hp/hp_max) * healthUImax;
	
	draw_set_halign(fa_left);
	draw_text(4,cooldown_posy-8,"hp: " + string(hp));
	draw_set_color(make_colour_rgb(23, 23, 43)); //hp bgr
	draw_rectangle(4,cooldown_posy+10,healthUImax,cooldown_posy+20,0);
	draw_set_color(make_colour_rgb(166, 252, 219)); //hp fgr
	draw_rectangle(4,cooldown_posy+10,healthUI,cooldown_posy+20,0);

	//extra texts
	DrawSetText(c_white,fUI,fa_left, fa_top);
	draw_text(4,4,"Lightfall Demo ");
	draw_text(4,20,"Update: Zoom Entry");
	draw_text(4,36,"x y" + string(oPlayer.y));
	//draw exp
	draw_text_transformed(RES_W-100,19,string(global.exp_points) + " exp",killtextscale,killtextscale,0);
		
	//only display if you've had kills
	if  (global.kills > 0) {
		killtextscale = max(killtextscale * 0.85, 1); 	
		DrawSetText(c_white,fUI,fa_right, fa_top);
		draw_text_transformed(RES_W-5,19,string(global.kills) + " Kills",killtextscale,killtextscale,0);
	}
}