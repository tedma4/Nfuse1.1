require 'paperclip/av/transcoder'

Paperclip.configure do |c|
  c.register_processor :ffmpeg, Paperclip::Transcoder
end