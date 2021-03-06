require 'formula'

class Openni < Formula
  homepage 'http://www.openni.org/Downloads/OpenNIModules.aspx'
  # url 'http://www.openni.org/wp-content/uploads/2013/01/OpenNI-MacOS-x64-2.1.0.tar.zip'
  # url 'http://www.openni.org/wp-content/uploads/2012/12/OpenNI-Bin-Dev-MacOSX-v1.5.4.0.tar.zip'
  # url 'http://www.openni.org/wp-content/uploads/2012/12/OpenNI-Bin-Dev-MacOSX-v1.5.4.0.tar.bz2'
  url 'https://dl.dropbox.com/s/nqnzkbv9l9a52pv/OpenNI-Bin-Dev-MacOSX-v1.5.4.0.tar.bz2'
  md5 'b83d10190a45fee6e531e9629798c0b0'

  depends_on 'libusb'

  def install


    puts "Installing OpenNI"
    puts "copying executables..."
    bin.install Dir['Bin/ni*']
    puts "copying shared libraries..."
    lib.install Dir['Lib/*']
    puts "copying include files..."
    include.install Dir['Include/*']
    puts "creating database directory..."
    (var+'lib/ni').mkpath
    # if mono, then should install wrappers ... but not doing this yet
  end

  def caveats; <<-EOS.undent
    OpenNI requires libusb to be compiled as a Universal binary.

    If your Kinect does not work as expected, please try reinstalling libusb, like so:

    % brew uninstall libusb && brew install libusb --universal

    EOS
  end
end
