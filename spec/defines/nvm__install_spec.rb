require 'spec_helper'

describe 'nvm::install' do
  context 'component resource creation' do
    describe 'nvm::install with valid params' do
      user = ENV['USER']
      version = '0.20.0'
      let(:title) { user }
      let(:params) do
        {
          :version => version
        }
      end

      it { should compile.with_all_deps }

      it { should contain_nvm__install(user) }
      it { should contain_nvm__install(user).with_version(version) }

      installer_url = "https://raw.githubusercontent.com/creationix/nvm/v#{version}/install.sh"

      it { should contain_exec("install nvm for user #{user}") }
      it do
        should contain_exec("install nvm for user #{user}").with(
          'command' => "/bin/bash -c 'export NVM_DIR=~/.nvm; /usr/bin/curl #{installer_url} | /bin/bash -x'",
          'user'    => user,
        )
      end
    end
  end
  context 'input validation' do
    describe 'nvm::install with invalid version' do
      user = ENV['USER']
      version = 'asdf'
      let(:title) { user }
      let(:params) do
        {
          :version => version
        }
      end
      
      it "Should raise error about version not matching a version string" do
        expect { should create_nvm__install(user) }.to raise_error(Puppet::Error, /"asdf" does not match/)
      end
    end
  end
end
