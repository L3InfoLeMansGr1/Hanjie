require 'rmagick'
include Magick

cat = ImageList.new("apple.bmp")
cat.each_pixel{ |i|
  puts i
}
exit
