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
  ).each do |pkg|
    describe package pkg do
      it { is_expected.to be_installed }
    end
  end

  describe file '/etc/apache2/conf.d/h5bp.conf' do
    it { is_expected.to be_file }
    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'h5bp rules begin' }
    end
  end
end

describe 'Website Virtual Host' do
  describe user 'www-data' do
    it { is_expected.to belong_to_group 'deploy' }
  end

  describe file '/var/www/www.evertrue.com' do
    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by 'deploy' }
    it { is_expected.to be_grouped_into 'www-data' }
    it { is_expected.to be_mode '2775' }
  end

  describe file '/etc/apache2/sites-enabled/evertrue_com.conf' do
    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'ServerName www.evertrue.com' }
      it { is_expected.to match(%r{<Directory /var/www/www\.evertrue\.com/current/htdocs>\s+?Options \+FollowSymLinks\s+?AllowOverride All}) }
    end
  end
end

describe 'APC' do
  describe package 'php-apc' do
    it { is_expected.to be_installed }
  end

  describe file '/etc/php5/conf.d/apc.ini' do
    it { is_expected.to be_file }

    describe '#content' do
      subject { super().content }
      it { is_expected.to include 'apc.enabled = 1' }
      it { is_expected.to include 'apc.shm_segments = 1' }
      it { is_expected.to include 'apc.shm_size = 192M' }
      it { is_expected.to include 'apc.optimization = 0' }
      it { is_expected.to include 'apc.num_files_hint = 4096' }
      it { is_expected.to include 'apc.user_entries_hint = 4096' }
      it { is_expected.to include 'apc.ttl = 3600' }
      it { is_expected.to include 'apc.user_ttl = 3600' }
      it { is_expected.to include 'apc.gc_ttl = 1800' }
      it { is_expected.to include 'apc.cache_by_default = 1' }
      it { is_expected.to include "apc.filters = \n" }
      it { is_expected.to include 'apc.mmap_file_mask = /apc.shm.XXXXXX' }
      it { is_expected.to include 'apc.slam_defense = 0' }
      it { is_expected.to include 'apc.file_update_protection = 2' }
      it { is_expected.to include 'apc.enable_cli = 0' }
      it { is_expected.to include 'apc.max_file_size = 2M' }
      it { is_expected.to include 'apc.stat = 1' }
      it { is_expected.to include 'apc.write_lock = 1' }
      it { is_expected.to include 'apc.report_autofilter = 0' }
      it { is_expected.to include 'apc.include_once_override = 0' }
      it { is_expected.to include 'apc.localcache = 0' }
      it { is_expected.to include 'apc.localcache.size = 2048' }
      it { is_expected.to include 'apc.coredump_unmap = 0' }
      it { is_expected.to include 'apc.stat_ctime = 0' }
      it { is_expected.to include 'apc.canonicalize = 1' }
    end
  end
end
