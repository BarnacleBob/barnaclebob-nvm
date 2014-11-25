require 'spec_helper'

describe 'nvm' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "nvm class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('nvm::params') }
        it { should contain_class('nvm::install').that_comes_before('nvm::config') }
        it { should contain_class('nvm::config') }
        it { should contain_class('nvm::service').that_subscribes_to('nvm::config') }

        it { should contain_service('nvm') }
        it { should contain_package('nvm').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'nvm class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('nvm') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
