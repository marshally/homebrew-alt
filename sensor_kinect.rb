require 'formula'

class SensorKinect < Formula
  homepage 'https://github.com/avin2/SensorKinect'
  url 'https://github.com/downloads/avin2/SensorKinect/SensorKinect092-Bin-MacOSX-v5.1.2.1.tar.bz2'
  md5 'aeac7b8843c6e9fe51e5cba936b1ab07'

  depends_on 'openni'
  depends_on 'nite'

  def install
    lib.install Dir["Lib/*"]
    bin.install Dir["Bin/*"]
    etc.install "Config/GlobalDefaultsKinect.ini"
    (var + 'log/sensor_kinect').mkpath

    Dir["#{lib}/*"].each do |base|
      so = base.split("/").last
      puts "Registering module '#{so}'... " if ENV['V']
      cmd = "export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}; niReg -v #{lib}/#{so} #{etc}"
      if `#{cmd}`.include? "Error"
        puts "Error installing #{base}"
        exit 1
      end
    end
  end

  def caveats; <<-EOS.undent
    You will have to instruct the NITE framework that libraries have been installed in the Homebrew directory, instead of the standard locations.
    
    To export the needed variables, add them to your dotfiles.
      * On Bash, add them to `~/.bash_profile`.
      * On Zsh, add them to `~/.zprofile` instead.

    export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}
    EOS
  end
end