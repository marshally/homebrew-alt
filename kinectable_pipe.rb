require 'formula'

class KinectablePipe < Formula
  homepage 'https://github.com/marshally/kinectable_pipe'
  url 'https://github.com/marshally/kinectable_pipe/tarball/v0.0.2'
  version '0.0.2'
  md5 'a7c7bb602293de850f4108912634f5f6'

  depends_on 'sensor_kinect'

  def install
    system 'make clean'
    bin.install 'kinectable_pipe'
  end
end
