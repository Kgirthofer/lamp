require 'spec_helper'
require 'rspec/expectations'

describe 'lamp::prep' do
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

    describe 'installing packages' do
      %w(
        httpd24
        php56
        mysql55-server
        php56-mysqlnd
        expect
      ).each do |package|
        it { is_expected.to install_package package }
      end
    end

    describe 'groups' do
      it { is_expected.to create_group('www') }
    end
  end
end
