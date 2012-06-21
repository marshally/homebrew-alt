require 'formula'

class KinectablePipe < Formula
  homepage 'https://github.com/marshally/kinectable_pipe'
  url 'https://github.com/marshally/kinectable_pipe/tarball/master'
  version '1.0'
  md5 'a9662ee3e4756319d621a5bf5c7ac720'

  depends_on 'sensor_kinect'

  def install
    system 'make clean'
    bin.install 'kinectable_pipe'
  end
end
