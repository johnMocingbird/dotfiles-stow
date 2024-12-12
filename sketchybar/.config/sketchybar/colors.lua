return {
	black = 0xFF15161E,
	white = 0xFFA9B1D6,
	red = 0xFFF7768E,
	green = 0xFF9ECE6A,
	blue = 0xFF7AA2F7,
	yellow = 0xFFE0AF68,
	orange = 0xFFFF9E64,
	magenta = 0xFFBB9AF7,
	grey = 0xff939ab7,
	transparent = 0x00000000,

	bar = {
		bg = 0xff1a1b26,
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0Xff1a1b26,
		border = 0xff7f8490,
	},
	bg1 = 0Xff1a1b26,
	bg2 = 0x60494d64,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
