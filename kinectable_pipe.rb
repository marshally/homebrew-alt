require 'formula'

class KinectablePipe < Formula
  homepage 'https://github.com/marshally/kinectable_pipe'
  url 'https://github.com/marshally/kinectable_pipe/tarball/v0.0.2'
  version '0.0.2'
  md5 '28d9d21da4ed15e249053f3d942301ff'

  depends_on 'sensor_kinect'

  def install
    system 'make clean'
    bin.install 'kinectable_pipe'
  end
end
