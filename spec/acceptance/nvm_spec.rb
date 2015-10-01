require 'spec_helper_acceptance'

describe 'nvm define' do
  describe 'applying manifest' do
    # Using puppet_apply as a helper
    it 'should work idempotently with no errors' do

      pp = <<-EOS
        user{'test':
          ensure     => present,
          managehome => true,
        }
        nvm{'test': }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes  => true)
    end

    describe file('/home/test/.nvm') do
      it { should be_directory }
    end

    it 'can run node' do
      shell('sudo -u test -i /bin/bash -c \'source $HOME/.nvm/nvm.sh; nvm run --version\'', :acceptable_exit_codes => 0)
    end
  end
end
