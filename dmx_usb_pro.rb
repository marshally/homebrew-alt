require 'formula'

class DmxUsbPro < Formula
  homepage 'http://www.enttec.com/index.php?main_menu=products&pn=70304&show=drivers'
  url 'http://www.enttec.com/dmx_usb/D2XX1.1.10.dmg'
  version '1.1.10'
  md5 'e6e914aca9eb3bbaff312c9e053c171e'

  def install
    mount_point = `hdiutil mount D2XX1.1.10.dmg`[/\/Volumes\/(\w+)/]

    # dmg is mounted read only, so we have to move files we want to
    # install to a tmp dir
    system "cp", "-R", "#{mount_point}", ENV["TMPDIR"]
    system "cp", "#{ENV["TMPDIR"]}release/D2XX/bin/10.5-10.7/libftd2xx.1.1.10.dylib", "#{ENV["TMPDIR"]}release/D2XX/bin/10.5-10.7/libftd2xx.dylib"

    lib.install "#{ENV["TMPDIR"]}release/D2XX/bin/10.5-10.7/libftd2xx.1.1.10.dylib"

    lib.install "#{ENV["TMPDIR"]}release/D2XX/bin/10.5-10.7/libftd2xx.dylib"
    `hdiutil detach #{mount_point}`
    
    include.install "#{ENV["TMPDIR"]}release/D2XX/Samples/ftd2xx.h"
    include.install "#{ENV["TMPDIR"]}release/D2XX/Samples/WinTypes.h"
  end
end
