interactables = [
	o_interactparent,
	o_npc_parent,
];

state = PLAYER_STATES.free;
image_speed = 0;
facing = global.facing;
moving = 0;
movement = 1;
moveable = true;

dsprite = spr_actor_mainpl_d;
rsprite = spr_actor_mainpl_r;
usprite = spr_actor_mainpl_u;
lsprite = spr_actor_mainpl_l;

hsp = 0;
vsp = 0;
spd = 3;

if (global.facing == FACES.DOWN)
	sprite_index = dsprite;
if (global.facing == FACES.RIGHT)
	sprite_index = rsprite;
if (global.facing == FACES.UP)
	sprite_index = usprite;
if (global.facing == FACES.LEFT)
	sprite_index = lsprite;

inwater = 0;
in_cutscene = false;
s_override = false;

collision = function(object=block){
	if (hsp!=0&&place_meeting(x+hsp,y,object)){
		var d=sign(hsp)
		var ok=false
		for (var i=1;i<=8;i++){
			if (!place_meeting(x+hsp,y-i,object)){
				y-=1
				ok=true
				break;
			}
			if (!place_meeting(x+hsp,y+i,object)){
				y+=1
				ok=true
				break;
			}
		}
		if (!ok){
			while (!place_meeting(x+d,y,object))
				x+=d
			hsp=0
		}
	}

	if (vsp!=0&&place_meeting(x,y+vsp,object)){
		var d=sign(vsp)
		var ok=false

		for (var i=1; i<=8; i++){
			if (!place_meeting(x-i,y+vsp,object)){
				x-=1
				ok=true
				break;
			}
			if (!place_meeting(x+i,y+vsp,object)){
				x+=1
				ok=true
				break;
			}
		}

		if (!ok){
			while (!place_meeting(x,y+d,object)) y+=d
			vsp=0
		}
	}
}

function direction_animation(){
	if (abs(hsp)>abs(vsp)){
		if (hsp>0) global.facing = FACES.RIGHT
		if (hsp<0) global.facing = FACES.LEFT
	}
    else{
		if (vsp>0) global.facing = FACES.DOWN
		if (vsp<0) global.facing = FACES.UP
	}
}
	
frisk_dance = function() { //by namuframes
    if (instance_place(x,y-spd,o_solidparent)) {
        if (InputPressedCheck(INPUT.DOWN) && InputPressedCheck(INPUT.UP)) {
            if (global.facing == FACES.LEFT || global.facing == FACES.RIGHT) {global.facing = FACES.UP}
            vsp += spd;
        }
    }
}