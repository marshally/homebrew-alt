require 'formula'

class Nite < Formula
  homepage 'http://www.openni.org/Downloads/OpenNIModules.aspx'
  url 'https://bitbucket.org/kaorun55/openni-1.5.2.23-unstable/src/526703f543a5/Mac_OS/nite-bin-macosx-v1.5.2.21.tar.bz2'
  md5 '059d9a2315a0244dc86fea9ad03e0fcf'

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
          cmd = "export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}; niReg -v -r #{lib}/#{base} #{etc}/primesense/#{feature}"
          if `#{cmd}`.include? "Error"
            puts "Error installing #{base}"
            exit 1
          end
        elsif so.include? "XnVSceneServer"
          bin.install so
        end
      end
    end

    # these libs actually come from the openni.rb formula, but can't be
    # installed due to the order that homebrew installs things
    ["libnimMockNodes.dylib", "libnimCodecs.dylib", "libnimRecorder.dylib"].each do |mod|
      fullpath = "#{HOMEBREW_PREFIX}\/lib\/#{mod}"
      if File.exists? fullpath
        cmd = "export OPEN_NI_INSTALL_PATH=#{HOMEBREW_PREFIX}; niReg -r -v #{fullpath}"
        unless `#{cmd}`.include? "Done"
          puts "Error installing #{mod}"
          puts "#{cmd}"
          exit 1
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

    Also, expect some errors that look like:
      Warning: Could not fix install names for ...

    EOS
  end
end
