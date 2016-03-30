# -*- encoding : utf-8 -*-

require_relative 'spec_helper'

# This test makes sure that even when using partial version strings to install
# the latest stable version of a Ruby that they still get installed into a
# directory with the full version string.
#
# Example:
# ruby_install_ruby 'ruby 2.1' installs to a directory named ruby-2.1.x
# not ruby-2.1.

describe 'Rubies installed via partial version have correctly named dirs' do
  describe command('ls /opt/rubies') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /ruby-2\.1\.\d{1,2}/ }
  end
end
