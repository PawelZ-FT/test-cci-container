control "base_container" do

  impact 1.0
  title "Checking base container"
  desc "Checking tomcat user and dirs, JDK8"


  describe file('/container-entry.sh') do
  	it { should exist }
  	it { should be_file }
  	it { should be_owned_by 'root' }
  	its('group') { should eq 'root' }
  	its('mode') { should cmp '0755' }
  end

  describe file('/usr/local/bin/ec2-metadata') do
  	it { should exist }
  	it { should be_file }
  	it { should be_owned_by 'root' }
  	its('group') { should eq 'root' }
  	its('mode') { should cmp '0755' }
  end
  
  # The `package` resource is not supported on your OS yet.
  #describe package('openjdk8') do
  #	it { should be_installed }
  #	its('version') { should cmp >= '8' }
  #end

  describe file('/usr/bin/java') do
  	it { should exist }
  	it { should be_symlink }
  end

  java = inspec.command('/usr/bin/java -version')
  describe java do
  	its('exit_status') { should eq 0 }
    its('stderr') { should match /^(openjdk|java) version "1.8.0_[0-9]+"$/ }
    its('stderr') { should match /^(OpenJDK|Java HotSpot\(TM\)) 64-Bit Server VM \(.*, mixed mode\)$/ }
  end
    
  describe user('tomcat') do
  	it { should exist }
  	its('group') { should eq 'tomcat' }
    its('groups') { should eq ['tomcat']}
    its('home') { should eq '/usr/local/tomcat' }
    its('shell') { should eq '/sbin/nologin' }
  end

  %w(
     /usr/local/tomcat
     /usr/local/tomcat/webapps
     /usr/local/tomcat/work
     /usr/local/tomcat/temp
     /usr/local/tomcat/logs
    ).each do |directory|
    	describe file(directory) do
    	  it { should exist }
    	  it { should be_directory }
    	  it { should be_owned_by 'tomcat' }
    	  its('group') { should eq 'tomcat' }
    	end
    end

  webapps_ls = inspec.command('ls -l /usr/local/tomcat/webapps/')
  describe webapps_ls do
    its('exit_status') { should eq 0 }
    its('stdout') { should match /^total 0$/ }
  end

  describe file('/tmp/apache-tomcat.tgz') do
  	it { should_not exist }
  end

  describe os_env('PATH') do
  	its('content') { should include '/usr/lib/jvm/java-1.8-openjdk/bin' }
  end

  describe os_env('JAVA_HOME') do
  	its('content') { should eq '/usr/lib/jvm/java-1.8-openjdk' }
  end


 end