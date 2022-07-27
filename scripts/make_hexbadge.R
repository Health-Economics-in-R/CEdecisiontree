library(hexSticker)

library(showtext)
## Loading Google fonts (http://www.google.com/fonts)
font_add_google("lobster")
## Automatically use showtext to render text for future devices
showtext_auto()

sticker(
  "man/figures/tree.png",
  package = "CEdecisiontree",
  p_size = 15,
  s_x = 1,
  s_y = 0.8,
  s_width = 0.5,
  filename = "man/figures/hexbadge.svg",
  h_fill = "white",
  h_color = "darkgreen",
  p_y = 1.5,
  p_color = "brown",
  p_family = "lobster",
  spotlight = FALSE,
  url = "https://health-economics-in-r.github.io/CEdecisiontree",
  u_size = 3,
  u_y = 0.05,
  l_alpha = 1,
  l_y = 0.85)
