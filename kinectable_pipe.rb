require 'formula'

class KinectablePipe < Formula
  homepage 'https://github.com/marshally/kinectable_pipe'
  url 'https://github.com/marshally/kinectable_pipe/tarball/master'
  version '1.0'
  md5 'f99858bf86bb26efc9d4bf9555de9156'

  depends_on 'sensor_kinect'

  def install
    system 'make clean'
    bin.install 'kinectable_pipe'
  end
end
