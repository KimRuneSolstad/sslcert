# module_root/spec/acceptance/standard_spec.rb
require 'spec_helper_acceptance'

describe 'sslcert class' do

  # Using puppet_apply as a helper
  it 'should work with no errors based on the example' do
    pp = <<-EOS
    class {'sslcert':
      certificate => 'puppet:///modules/sslcert/root/certs/ca.cert.pem'
    }
#    notice('IT WORKED, OH MY GO IT WORKED') 
#    exec { 'openssl':
#      command => 'openssl version',
#      path    => '/etc/ssl/',
#    }

    EOS

    # Run it twice and test for idempotency
    expect(apply_manifest(pp).exit_code).to_not eq(1)
    expect(apply_manifest(pp).exit_code).to eq(0)
  end
end
