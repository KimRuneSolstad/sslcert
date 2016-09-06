# module_root/spec/acceptance/standard_spec.rb
require 'spec_helper_acceptance'

describe 'sslcert class' do

  # Using puppet_apply as a helper
  it 'should work with no errors based on the example' do
    pp = <<-EOS
    include sslcert
#    class {'sslcert':
#      certificate => 'puppet:///modules/sslcert/root/certs/ca.cert.pem'
#    }
    EOS

    # Run it twice and test for idempotency
    expect(apply_manifest(pp).exit_code).to_not eq(1)
    expect(apply_manifest(pp).exit_code).to eq(0)
  end

  context 'managing CA' do

    describe file('/etc/ssl/CA/serial') do
      it { should be_file }
    end

    describe file('/etc/ssl/CA/index.txt') do
      it { should be_file }
    end

    describe file('/etc/ssl/CA/openssl.cnf') do
      it { should be_file }
    end

    describe file('/etc/ssl/private/ca.key.pem') do
      it { should be_file }
    end

    describe file('/etc/ssl/certs/ca.cert.pem') do
      it { should be_file }
    end

  end

end
