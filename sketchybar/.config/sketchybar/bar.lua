local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
  height = 40,
  color = colors.bar.bg,
  padding_right = 2,
  padding_left = 2,
  -- Bar appears on all displays, items control which display they show on
})
