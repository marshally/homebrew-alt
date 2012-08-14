require 'formula'

class OpenLighting < Formula
  homepage 'http://www.opendmx.net/'
  url 'http://open-lighting.googlecode.com/files/ola-0.8.20.tar.gz'
  version '0.8.20'
  md5 '421983a8e8d04540d5c769bfda0da3d7'

  depends_on "python"
  depends_on "libusb"
  depends_on "cppunit"
  depends_on "pkg-config"
  depends_on "protobuf"
  depends_on "protobuf-c"
  depends_on "libmicrohttpd"

  def install
    system "autoreconf -i"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-slp" # , --enable-python-libs"

    system "make"
    system "make check"
    system "make install"
  end
end
