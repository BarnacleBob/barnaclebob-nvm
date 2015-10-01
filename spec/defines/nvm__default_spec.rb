require 'spec_helper'

describe 'nvm::default' do
  context 'component resource creation' do
    describe 'nvm::default with valid params' do
      user = ENV['USER']
      version = '0.10.0'
      let(:title) { user }
      let(:params) do
        {
          :version => version
        }
      end

      it { should compile.with_all_deps }

      it { should contain_nvm__default(user) }
      it { should contain_nvm__default(user).with_version(version) }

      it { should contain_exec("set default node version to #{version} for #{user}") }
      it do 
        should contain_exec("set default node version to #{version} for #{user}").with(
          'command'  => "/bin/bash -c 'source ~/.nvm/nvm.sh && nvm alias default #{version}'",
          'user'     => user,
        )
      end
    end
  end
  context 'input validation' do
    describe 'nvm::default with invalid version' do
      user = ENV['USER']
      version = 'asdf'
      let(:title) { user }
      let(:params) do
        {
          :version => version
        }
      end
      
      it "Should raise error about version not matching a version string" do
        expect { should create_nvm__default(user) }.to raise_error(Puppet::Error, /"asdf" does not match/)
      end
    end
  end
end
