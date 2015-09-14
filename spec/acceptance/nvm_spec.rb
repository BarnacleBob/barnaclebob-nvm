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
  end

  describe file('/home/test/.nvm') do
    it { should be_directory }
  end
end
