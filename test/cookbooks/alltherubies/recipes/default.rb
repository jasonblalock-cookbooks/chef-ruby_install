# -*- encoding : utf-8 -*-
# Be specific with version and patch level as this is hardcoded in the tests.
#
# Not testing Maglev as ./configure complains if run as root and fails, also
# compiling Maglev consistantly locks up my machine (old hardware).

ruby_install_ruby 'ruby 2.2.4'
ruby_install_ruby 'ruby 2.3.0'
ruby_install_ruby 'jruby 1.7.24'
# Having issues with llvm-config
# abort unable to set up llvm
#ruby_install_ruby 'rbx 2.71828182'
