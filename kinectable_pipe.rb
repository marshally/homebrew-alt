require 'formula'

class KinectablePipe < Formula
  homepage 'https://github.com/marshally/kinectable_pipe'
  url 'https://github.com/marshally/kinectable_pipe/tarball/v0.0.3'
  version '0.0.3'
  md5 '7f4b3cbb4409ad50be85835363ca91bb'

  depends_on 'sensor_kinect'
  depends_on 'png++'

  def install
    system 'make clean'
    bin.install 'kinectable_pipe'
  end
end
