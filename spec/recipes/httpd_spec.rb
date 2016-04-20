require 'spec_helper'
require 'rspec/expectations'

describe 'lamp::httpd' do
  ## initialize our run with fauxhai
  cached(:chef_run) { default_chef_run }
  subject { chef_run }

  before do
    stub_command(/.*/).and_return true
    allow(Chef::EncryptedDataBagItem).to receive(:load).and_return({})
  end

  context 'when os is amazon linux' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'amazon',
        version: '2015.09'
      ).converge(described_recipe)
    end
    subject { chef_run }
    
    describe 'services' do
      it { is_expected.to start_service('httpd') }
      it { is_expected.to enable_service('httpd') }
    end

    describe 'groups' do
      it { is_expected.to modify_group('www') }
    end

    describe 'permissions' do
      it { is_expected.to run_bash('var-www-perms') }
    end
  end
end
