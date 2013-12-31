# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/ios'

begin
  require 'bundler'
  Bundler.require
  
  require 'sugarcube-all'
  require 'ProMotion'
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'Barcode'
  app.icons = ['icon.png']
  app.frameworks += ['AVFoundation']
  
  app.codesign_certificate = 'iPhone Developer: xxx'
  app.provisioning_profile = 'xxx'
  
end
