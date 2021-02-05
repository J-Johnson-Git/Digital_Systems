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


int main(void)
{
	set_char('7');
	set_x_pos(144);
	set_y_pos(35);

	return 0;
}
