require 'spec_helper'

describe 'nvm::install::version' do
  context 'component resource creation' do
    describe 'nvm::install::version with valid title' do
      user = ENV['USER']
      version = 'stable'
      let(:title) { "#{user}:#{version}" }
      let(:params) {{ }}

      it { should compile.with_all_deps }

      it { should contain_nvm__install__version("#{user}:#{version}") }

      it { should contain_exec("install node #{version} for #{user}") }
      it do
        should contain_exec("install node #{version} for #{user}").with(
          'command'  => "/bin/bash -c '. ~/.nvm/nvm.sh && nvm install #{version}'",
          'user'     => user,
        )
      end
    end
  end
  context 'input validation' do
    describe 'invalid title' do
      let(:title) { 'something' }
      let(:params) {{ }}

      it "Should raise error about title not matching pattern" do
        expect { should create_nvm__install__version('something') }.to raise_error(Puppet::Error, /"something" does not match/)
      end
    end
  end
end
