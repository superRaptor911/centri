shader_type canvas_item;

void vertex()
{
	//VERTEX *= 2.0 * sin(TIME * 2.0);
}

void fragment()
{
	COLOR= texture(TEXTURE,UV) * max(max(sin(TIME * 2.0),cos(TIME * 2.0)), 0.55);
	 
}