require 'formula'

class KinectablePipe < Formula
  homepage 'https://github.com/marshally/kinectable_pipe'
  url 'https://github.com/marshally/kinectable_pipe/tarball/v0.0.4'
  version '0.0.4'
  md5 '905035b60823c3e0d9904bbfaf74eec6'

  depends_on 'sensor_kinect'
  depends_on 'png++'

  def install
    if MacOS.snow_leopard?    
      text = File.read("Makefile")
      text.gsub!(/png15/, "png12")
      File.open("Makefile", "w") {|file| file.puts text}
    end
    system 'make clean'
    bin.install 'kinectable_pipe'
  end
end
