control "base_container" do

  impact 1.0
  title "Checking base container"
  desc "Checking tomcat user and dirs, OpenJDK8"

  describe package('openjdk8') do
  	it { should be_installed }
  	its('version') { should cmp >= '8' }
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
      its('stdout') { should eq 'total 0\n' }
    end

    describe os_env('PATH') do
      its('content') { should include '/usr/lib/jvm/java-1.8-openjdk/bin' }
    end

    describe os_env('JAVA_HOME') do
      its('content') { should eq '/usr/lib/jvm/java-1.8-openjdk' }
    end


 end