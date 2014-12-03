require 'spec_helper'

describe 'nvm' do
  context 'component resource creation' do
    describe "nvm define without any parameters" do
      user = ENV['USER']
      let(:title) { user }
      let(:params) {{ }}
      let(:facts) {{
        :osfamily => 'Redhat',
      }}

      it { should compile.with_all_deps }

      it { should contain_nvm(user) }

      it { should contain_nvm__install(user) }
      it { should contain_nvm__install(user).that_comes_before("Nvm::Install::Version[#{user}:stable]") }
      it { should contain_nvm__install(user).with_version('0.20.0') }

      it { should contain_nvm__install__version("#{user}:stable") }
      it { should contain_nvm__install__version("#{user}:stable").that_comes_before("Nvm::Default[#{user}]") }

      it { should contain_nvm__default(user) }
      it { should contain_nvm__default(user).with_version('stable') }
      
      it { should contain_exec("install node stable for #{user}") }
    end
      
    describe "nvm with parameters" do
      user = ENV['USER']
      let(:title) { user }
      let(:params) {{
        :nvm_version => '9.9.9',
        :versions    => [
          '0.1.0',
          '0.2.0',
        ],
        :default_version => '0.2.0',
      }}
      let(:facts) {{
        :osfamily => 'Redhat',
      }}

      it { should compile.with_all_deps }

      it { should contain_nvm(user) }

      it { should contain_nvm__install(user) }
      it { should contain_nvm__install(user).with_version('9.9.9') }

      it { should contain_nvm__install__version("#{user}:0.1.0") }
      it { should contain_nvm__install__version("#{user}:0.2.0") }

      it { should contain_nvm__default(user) }
      it { should contain_nvm__default(user).with_version('0.2.0') }
      
      it { should contain_exec("install node 0.1.0 for #{user}") }
      it { should contain_exec("install node 0.2.0 for #{user}") }

      it { should contain_exec("set default node version to 0.2.0 for #{user}") }
    end
  end

  context "input validation" do
    describe "nvm with invalid default version" do
      user = ENV['USER']
      let(:title) { user }
      let(:params) {{
        :default_version => 'not_acceptable_version',
      }}
      let(:facts) {{
        :osfamily => 'Redhat',
      }}
      
      it "Should raise error about default version not matching acceptable version formats" do 
        expect { should create_nvm(user) }.to raise_error(Puppet::Error, /"not_acceptable_version" does not match "[^"]+"/)
      end
    end
    describe "nvm with invalid versions parameter" do
      user = ENV['USER']
      let(:title) { user }
      let(:params) {{
        :versions => "this is not valid"
      }}
      let(:facts) {{
        :osfamily => 'Redhat',
      }}
      
      it "Should raise error about being passed a string and not an array" do 
        expect { should create_nvm(user) }.to raise_error(Puppet::Error, /"this is not valid" is not an Array./)
      end
    end
    ['0.1.0','stable','unstable','system'].each do |default_version|
      describe "nvm with default version #{default_version}" do
        user = ENV['USER']
        let(:title) { user }
        let(:params) {{
          :versions => ['0.1.0','stable','unstable'],
          :default_version => default_version,
        }}
        let(:facts) {{
          :osfamily => 'Redhat',
        }}

        it { should compile.with_all_deps }
        if default_version != 'system'
          it { should contain_exec("install node #{default_version} for #{user}") }
          it { should contain_nvm__install__version("#{user}:#{default_version}") }
        end
        it { should contain_exec("set default node version to #{default_version} for #{user}") }
      end
    end
    describe "nvm with default version not in installed versions" do
      user = ENV['USER']
      let(:title) { user }
      let(:params) {{
        :default_version => '0.9.0',
      }}
      let(:facts) {{
        :osfamily => 'Redhat',
      }}
      
      it "Should raise error about default version not in versions list" do 
        expect { should create_nvm(user) }.to raise_error(Puppet::Error, /default_version\(0.9.0\) must be in the list of installed versions \(stable\) or system/)
      end
    end
  end

  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "nvm define without any parameters on #{osfamily}" do
        user = ENV['USER']
        let(:title) { user }
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_nvm(user) }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'nvm class without any parameters on Solaris/Nexenta' do
      user = ENV['USER']
      let(:title) { user }
      let(:params) {{ }}
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it "Should raise error about unsupported os" do 
        expect { should create_nvm(user) }.to raise_error(Puppet::Error, /Nexenta not supported/)
      end
    end
  end
end
