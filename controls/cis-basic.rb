control 'cis-1-1' do
  impact 0.7
  title 'Ensure /etc/passwd permissions are configured'
  desc 'CIS requires passwd to be world-readable but not writable'
  
  describe file('/etc/passwd') do
    it { should exist }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('others') }
  end
end

control 'cis-1-2' do
  impact 0.7
  title 'Ensure /etc/shadow is properly permissioned'
  desc 'Shadow must be 600 and owned by root:shadow'

  describe file('/etc/shadow') do
    it { should exist }
    its('mode') { should cmp '0640' }  
    its('owner') { should eq 'root' }
    its('group') { should eq 'shadow' }
  end
end

control 'cis-2-1' do
  impact 0.5
  title 'Ensure SSH Protocol 2 is enabled'

  describe sshd_config do
    its('Protocol') { should cmp 2 }
  end
end

control 'cis-2-2' do
  impact 0.5
  title 'Ensure SSH root login is disabled'

  describe sshd_config do
    its('PermitRootLogin') { should cmp 'no' }
  end
end
