#!/usr/bin/python3
code = bytearray([
	# Intitalize Output B
	# Load value 0xFF to Register A
	0xa9, 0xff,
	# Store Value in Register A to 0x6002 which initializes Port B of 65C22 as OUTPUT
	0x8d, 0x02, 0x60,

	# Output data

	# Load value 0x55 to Register A
	0xa9, 0x55,
	# Store Value in Register A to 0x6000
	0x8d, 0x00, 0x60,

	# Load value 0xaa to Register A
	0xa9, 0xaa,
	# Store Value in Register A to 0x6000
	0x8d, 0x00, 0x60,

	# Loop Back (Jump to output data again)
	0x4c, 0x05, 0x80  # JMP $8005
	])

rom = code + bytearray([0xea] * (32768 - len(code)))

# Start-Vector
rom[0x7ffc] = 0x00
rom[0x7ffd] = 0x80

with open("./65c22-pattern.bin", "wb") as out_file:
	out_file.write(rom);
