require 'spec_helper'
require 'rspec/expectations'

describe 'lamp::mysql' do
  subject { chef_run }
  context "run" do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(
        platform: 'amazon',
        version: '2015.09') do |node|
      end.converge(described_recipe)
    end
    before :each do
      stub_command(/.*/).and_return true
      allow(Chef::EncryptedDataBagItem).to receive(:load).and_return(
        'sql_password' => {}
      )
    end

    describe "ruby block" do
      it {is_expected.to run_ruby_block('set install_sql')}
    end

    context 'when sql is not installed' do
      cached(:chef_run) do
        ChefSpec::ServerRunner.new(
          platform: 'amazon',
          version: '2015.09') do |node|
          node.set['lamp']['mysql']['install_sql'] = true
        end.converge(described_recipe)
      end
  
      describe 'services' do
        it { is_expected.to start_service('mysqld') }
      end
  
      describe 'permissions' do
        it { is_expected.to run_bash('mysql-install') }
      end
    end
  end
end 
