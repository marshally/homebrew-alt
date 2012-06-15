require 'formula'

class Nite < Formula
  homepage 'http://www.openni.org/Downloads/OpenNIModules.aspx'
  url 'http://www.openni.org/downloads/nite-bin-macosx-v1.5.2.21.tar.bz2'
  md5 '619d9fe68e376e650b17e52c794bdc37'

  depends_on 'openni'

  def install
    puts "Installing NITE" if ENV['V'] == '1'
    puts "Copying shared libraries... " if ENV['V'] == '1'
    
    lib.install Dir['Bin/libXnVNite*dylib']
    lib.install Dir['Bin/libXnVCNITE*dylib']
    lib.install Dir['Bin/libXnVNITE.jni*dylib']
    
    include.install Dir["Include/*"]
    (share+'java').install Dir['Bin/*.jar']

    (Dir["Features*"] + Dir["Hand*"]).each do |feature|
     `rm -rf #{etc}/primesense/#{feature}`
      (etc+"primesense/#{feature}").mkpath
      (etc+"primesense/#{feature}").install Dir["#{feature}/Data/*"]

      Dir["#{feature}/Bin/*"].each do |so|
        if so[/\.dylib\Z/]
          base=`basename #{so}`.strip

          puts "installing lib '#{so}'... " if ENV['V'] == '1'
          lib.install so
          puts "Registering module '#{base}'... " if ENV['V'] == '1'
          cmd = "export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}; niReg -v #{lib}/#{base} #{etc}/primesense/#{feature}"
          if `#{cmd}`.include? "Error"
            puts "Error installing #{base}"
            exit 1
          end
        elsif so.include? "XnVSceneServer"
          bin.install so
        end
      end
    end
    
    `export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}; niLicense PrimeSense 0KOIk2JeIBYClPWVnMoRKn5cdY4=`
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