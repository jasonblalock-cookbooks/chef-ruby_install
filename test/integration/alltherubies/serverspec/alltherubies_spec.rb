# -*- encoding : utf-8 -*-

require_relative 'spec_helper'

describe 'compiles and installs Ruby 2.2.4 into /opt/rubies' do
  describe command('/opt/rubies/ruby-2.2.4/bin/ruby -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /ruby 2.2.4.*/ }
  end
end

describe 'compiles and installs Ruby 2.3.0 into /opt/rubies' do
  describe command('/opt/rubies/ruby-2.3.0/bin/ruby -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /ruby 2.3.0.*/ }
  end
end

#describe 'compiles and installs Rubinius 2.5.5 into /opt/rubies' do
#  describe command('/opt/rubies/rbx-2.5.5/bin/ruby -v') do
#    its(:exit_status) { should eq 0 }
#    its(:stdout) { should match /rubinius 2.5.5.*/ }
#  end
#end

describe 'compiles and installs jRuby 1.7.24 into /opt/rubies' do
  describe command('/opt/rubies/jruby-1.7.24/bin/ruby -v') do
    its(:exit_status) { should eq 0 }
    its(:stdout) { should match /jruby 1.7.24.*/ }
  end
end
