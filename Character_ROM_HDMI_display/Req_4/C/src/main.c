#include "header.h"

void set_char(char user_char)
{
	data pass = (data)(user_char);
	*(char_sel) = pass;
}

void set_x_pos(data x)
{
	*(x_pos) = x;
}

void set_y_pos(data y)
{
	*(y_pos) = y;
}

void set_back_red(data br)
{
	*(back_color_red) = br;
}

void set_back_green(data bg)
{
	*(back_color_green) = bg;
}

void set_back_blue(data bb)
{
	*(back_color_blue) = bb;
}

void set_char_red(data cr)
{
	*(char_color_red) = cr;
}

void set_char_green(data cg)
{
	*(char_color_green) = cg;
}

void set_char_blue(data cb)
{
	*(char_color_blue) = cb;
}

int main(void)
{
	set_back_red(9);
	set_back_green(216);
	set_back_blue(70);
	set_char_red(3);
	set_char_green(170);
	set_char_blue(75);

	while (1)
	{
		set_char('&');
		set_x_pos(346);
		set_y_pos(104);
	}

	return 0;
}
