require 'spec_helper'

describe 'Web Server' do
  describe service 'apache2' do
    it { is_expected.to be_running }
    it { is_expected.to be_enabled }
  end

  describe port '80' do
    it { is_expected.to be_listening }
  end

  describe user 'deploy' do
    it { is_expected.to exist }
  end

  %w(
    php5-mysql
    php5-curl
    libapache2-mod-rpaf
    subversion
  ).each do |pkg|
    describe package pkg do
      it { is_expected.to be_installed }
    end
  end

  describe file '/etc/apache2/conf-enabled/php-fpm.conf' do
    it { is_expected.to be_file }
  end

  describe file '/etc/php5/fpm/pool.d/www.conf' do
    it { is_expected.to be_file }
    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'catch_workers_output = yes' }
    end
  end

  describe file '/etc/apache2/conf-enabled/h5bp.conf' do
    it { is_expected.to be_file }
    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'h5bp rules begin' }
    end
  end

  describe file '/etc/apache2/mods-enabled/rpaf.conf' do
    it { is_expected.to be_file }
    describe '#content' do
      subject { super().content }
      it do
        is_expected.to include(
          "<IfModule rpaf_module>\n" \
          "RPAFenable On\n" \
          "RPAFsethostname On\n" \
          "RPAFproxy_ips 127.0.0.1 ::1 10.29.245.51 10.67.138.74\n" \
          "RPAFheader X-Forwarded-For\n" \
          '</IfModule>'
        )
      end
    end
  end
end

describe 'Website Virtual Hosts' do
  describe user 'www-data' do
    it { is_expected.to belong_to_group 'deploy' }
  end

  %w(
    stage-www
    www
  ).each do |subdomain|
    site_dir = "/var/www/#{subdomain}.evertrue.com"
    [
      site_dir,
      "#{site_dir}/shared",
      "#{site_dir}/shared/web"
    ].each do |dir|
      describe file dir do
        it { is_expected.to be_directory }
        it { is_expected.to be_owned_by 'deploy' }
        it { is_expected.to be_grouped_into 'www-data' }
        it { is_expected.to be_mode '2775' }
      end
    end

    if subdomain == 'stage-www'
      wp_env = 'staging'
      db = 'stage-etwp'
    else
      wp_env = 'production'
      db = 'etwp'
    end

    describe file "#{site_dir}/shared/.env" do
      it { is_expected.to be_file }
      describe '#content' do
        subject { super().content }
        it { is_expected.to include "DB_NAME=#{db}" }
        it { is_expected.to include 'DB_USER=etwpadmin' }
        it { is_expected.to include 'DB_PASSWORD=@@TESTING_PASS@@' }
        it { is_expected.to include 'DB_HOST=www.cg0lvth7azzh.us-east-1.rds.amazonaws.com' }
        it { is_expected.to include "WP_ENV=#{wp_env}" }
        it { is_expected.to include "WP_HOME=http://#{subdomain}.evertrue.com" }
        it { is_expected.to include "WP_SITEURL=http://#{subdomain}.evertrue.com/wp" }
      end
    end

    describe file "#{site_dir}/shared/web/.htaccess" do
      it { is_expected.to be_file }
      it { is_expected.to be_owned_by 'deploy' }
      it { is_expected.to be_grouped_into 'www-data' }
      it { is_expected.to be_mode '664' }
    end

    describe file "#{site_dir}/shared/web/app/uploads" do
      it { is_expected.to be_linked_to "/mnt/dev0/#{subdomain}/uploads" }
    end
  end

  describe file '/etc/apache2/sites-enabled/00_evertrue_com.conf' do
    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'ServerName www.evertrue.com' }
      it { is_expected.to match(%r{<Directory /var/www/www\.evertrue\.com/current/web>\s+?Options \+FollowSymLinks\s+?AllowOverride All}) }
    end
  end

  describe file '/etc/apache2/sites-enabled/20_stage_evertrue_com.conf' do
    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'ServerName stage-www.evertrue.com' }
      it { is_expected.to match(%r{<Directory /var/www/stage-www\.evertrue\.com/current/web>\s+?Options \+FollowSymLinks\s+?AllowOverride All}) }
    end
  end
end

describe 'WP-CLI' do
  describe file '/usr/local/bin/wp' do
    it { is_expected.to be_file }
    it { is_expected.to be_mode '755' }
  end

  describe command 'sudo -u deploy -i -- wp --info' do
    its(:exit_status) { is_expected.to eq 0 }
    its(:stdout) { is_expected.to match(/PHP version:\s+5.5/) }
    its(:stdout) { is_expected.to match(/WP-CLI version:\s+0.20.1/) }
  end
end
