# https://blog.cloudpack.jp/2011/08/11/server-news-centos6-monit-install/

package 'monit' do
  action :install
end

remote_file '/etc/init/monit.conf' do
  # https://github.com/arnaudsj/monit/blob/master/contrib/monit.upstart
  source 'files/etc/init/monit.conf'
  owner 'root'
  group 'root'
  mode '0600'
end

remote_file '/etc/monit.d/sshd.conf' do
  source 'files/etc/monit.d/sshd.conf'
  owner 'root'
  group 'root'
  mode '0600'
end

remote_file '/etc/monit.d/crond.conf' do
  source 'files/etc/monit.d/crond.conf'
  owner 'root'
  group 'root'
  mode '0600'
end

remote_file '/etc/monit.d/ntpd.conf' do
  source 'files/etc/monit.d/ntpd.conf'
  owner 'root'
  group 'root'
  mode '0600'
end

remote_file '/etc/monit.d/rsyslog.conf' do
  source 'files/etc/monit.d/rsyslog.conf'
  owner 'root'
  group 'root'
  mode '0600'
end

execute 'set cron monit' do
  not_if 'cat /var/spool/cron/root | grep "/usr/bin/monit monitor all"'
  command <<-EOL
    echo 'set httpd port 2812 and use address localhost allow localhost' >> /etc/monit.conf
    echo '0 */1 * * * /usr/bin/monit monitor all' >> /var/spool/cron/root
  EOL
end

execute 'upstart monit' do
  not_if 'initctl list | grep "monit start/running"'
  command <<-EOL
    initctl reload-configuration
    initctl start monit
  EOL
end
