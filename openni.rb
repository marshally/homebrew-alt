require 'formula'

class Openni < Formula
  homepage 'http://www.openni.org/Downloads/OpenNIModules.aspx'
  url 'http://www.openni.org/downloads/openni-bin-dev-macosx-v1.5.4.0.tar.bz2'
  md5 'b83d10190a45fee6e531e9629798c0b0'

  depends_on 'libusb'

  def install
    `rm Bin/OpenNI.net.dll`
    puts "Installing OpenNI" if ENV['V'] == '1'
    puts "copying shared libraries..." if ENV['V'] == '1'
    lib.install Dir['Lib/*']
    puts "copying executables..." if ENV['V'] == '1'
    bin.install Dir['Bin/*']
    puts "copying include files..." if ENV['V'] == '1'
    include.install Dir['Include/*']
    
    puts "creating database directory..." if ENV['V'] == '1'
    (var+'lib/ni').mkpath
    puts "Installing modules" if ENV['V'] == '1'
    ["libnimMockNodes.dylib", "libnimCodecs.dylib", "libnimRecorder.dylib"].each do |mod|
      `export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}; niReg -r #{lib}\/#{mod}`
    end
    # if mono, then should install wrappers ... not doing this yet
  end

  def caveats; <<-EOS.undent
    OpenNI requires libusb to be compiled as a Universal binary. If your Kinect does not work as expected, please try reinstalling libusb, like so:

    % brew uninstall libusb && brew install libusb --universal

    EOS
  end
end