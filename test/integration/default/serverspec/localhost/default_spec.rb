require 'spec_helper'

## see http://serverspec.org/
describe 'packages' do
  %w(
  ).each do |pkg|
    describe package pkg do
      it { should be_installed }
    end
  end
end

describe 'services that should always be enabled AND running' do
  %w(httpd mysqld).each do |service|
    describe service service do
      it { should be_enabled }
      it { should be_running }
    end
  end
end

describe 'validate passwd file' do
  describe file('/etc/passwd') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
  end
end

describe 'validate sudoers configuration' do
  describe file('/etc/sudoers') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 440 }
  end

  describe file('/etc/sudo.conf') do
    its(:content) { should match(/^Set disable_coredump false/) }
    its(:content) { should match(/^Plugin sudoers_policy sudoers.so/) }
    its(:content) { should match(/^Plugin sudoers_io sudoers.so/) }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 640 }
  end
end

