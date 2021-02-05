This project consists of a pre-created block of ROM containing all of the ASCII characters.
I reused the VGA signal generator, and connected it to a pre-supplied VGA-HDMI convertor IP
block. I created a ROM controller system that fetches ASCII characters from the ROM, and displays
them via the HDMI port. I also created a firmware system to select which character from ROM to fetch,
and what colors the character and foreground on the display monitor should be.

1. Create a VGA IP and connect it to the Real Digital’s HDMI IP to display solid square on the screen using HDMI
2. Display a character on the screen using the provided char_rom.v file
3. Make the system software controlled
4. Use ascii characters and color functionality