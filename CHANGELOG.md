et_www cookbook
===============

v5.1.1 (2015-09-24)
-------------------

* Fix key nane for PHP-FPM config `pm.max_requests`
* Add test that PHP-FPM is up & running (avoids using bad config values)
* Remove no longer needed resources to clean up old Apache vhost configs

v5.1.0 (2015-09-24)
-------------------

* Add logging of PHP-FPM workers
* Tune PHP-FPM performance
* Fix collision of PHP-FPM pool names
    - The default pool config, `www.conf` is deleted as part of the `php_fpm_pool` resource (see [line 39 of fpm_pool.rb](https://github.com/chef-cookbooks/php/blob/v1.7.2/providers/fpm_pool.rb#L39))
        + On first convergence, our pool is created, then destroyed, because it shares a name with the default
        + Subsequent convergences bring it back, and do not delete anything

v5.0.0 (2015-09-01)
-------------------

* Remove New Relic app monitoring

v4.0.3 (2015-08-24)
-------------------

* Ensure `mysqldump` is installed for local pull of stage/prod DBs

v4.0.2 (2015-08-13)
-------------------

* Add redirects from blog.evertrue.com and nerds.evertrue.com to various sites

v4.0.1 (2015-08-06)
-------------------

* Remove php5 Apache module

v4.0.0 (2015-08-06)
-------------------

* Switch to using php-fpm instead of mod_php
* Switch to the `event` Apache MPM for better concurrency 
* Fix path to New Relic PHP Agent config
    - Previously, we were creating a whole separate file, which resulted in having two active configs for the PHP Agent (potentially bad)

v3.4.5 (2015-08-06)
-------------------

* Remove wp-admin access control

v3.4.4 (2015-08-06)
-------------------

* Fix Apache syntax for wp-admin access control

v3.4.3 (2015-08-06)
-------------------

* Fix external access to admin-ajax.php for WP plugins that use it

v3.4.2 (2015-08-05)
-------------------

* Disable outside access to the wp-admin pages

v3.4.1 (2015-07-16)
-------------------

* Disable inclusion of New Relic MeetMe Plugin Agent
    - Troubleshooting step, may be responsible for overload on Apache

v3.4.0 (2015-07-16)
-------------------

* Add the New Relic PHP Agent back in to monitor for speed/load issues
* Move the uploads to a secondary mountpoint, if any
* Update some Serverspec tests

v3.3.0 (2015-04-16)
-------------------

* Install APCu for better caching w/ W3 Total Cache for WordPress

v3.2.0 (2015-04-16)
-------------------

* Update H5BP Apache config goodies to [h5bp/server-configs-apache@2.14.0](https://github.com/h5bp/server-configs-apache/blob/2.14.0/dist/.htaccess)

v3.1.1 (2015-04-16)
-------------------

* Damned preceding slashes

v3.1.0 (2015-04-16)
-------------------

* Add filename-based cachebusting to vhost configs
* Fix incorrect docroot for prod (for new deployments)
* Ensure a shared .htaccess file is present

v3.0.3 (2015-04-15)
-------------------

* Switch back to allowing app to handle its DB_PREFIX in code

v3.0.2 (2015-04-15)
-------------------

* Fix missing DB_PREFIX from .env

v3.0.1 (2015-04-15)
-------------------

* Fix DocumentRoot to reflect new WWW deployment

v3.0.0 (2015-04-14)
-------------------

* Refactor to install Apache 2.4 & PHP 5.5 on Ubuntu 14.04

v2.9.0 (2015-04-14)
-------------------

* Add installation of [Composer](https://getcomposer.org)

v2.8.0 (2015-04-14)
-------------------

* Add .env file for WordPress config data

v2.7.0 (2015-04-14)
-------------------

* Add [WP-CLI](http://wp-cli.org) to provide for [capistrano-wpcli](https://github.com/lavmeiker/capistrano-wpcli)

v2.6.0 (2015-04-01)
-------------------

* Add `stage-www.evertrue.com` as a separate vhost, instead of as an alias that can be used on a separately provisioned EC2 instance

v2.5.1 (2015-02-03)
-------------------

* Fix installation of `mod_rpaf` to be less janky
* Fix installation of `mod_rpaf` to use supplied config
* Add tests for `mod_rpaf` install/config
* Better handling of New Relic attributes for testing

v2.5.0 (2015-01-23)
-------------------

* Add `mod_rpaf` to better handle identifying visitors via the ELB
* Hacky blacklisting of bad actor

v2.4.0 (2014-10-20)
-------------------

* Add missing Ubuntu packages to be installed for WP to be fully functional
* Update H5BP Apache rules
    - See h5bp/html5-boilerplate@d7976c3f75a88c054dd75af88e78d7ba55e08119
* Update New Relic cookbooks to latest releases

v2.3.1 (2014-10-02)
-------------------

* Fix New Relic plugin agent name/path for APC monitoring

v2.3.0 (2014-09-30)
-------------------

* Disable New Relic app monitoring

v2.2.0 (2014-09-23)
-------------------

* Remove filename-based cachebusting from H5BP Apache config in favor of including at application level via `.htaccess`

v2.1.0 (2014-09-22)
-------------------

* Merge v1.4.0 into v2.0.0 branch

v2.0.0 (2014-09-19)
------------------

* Replace newrelic-ng cookbook with newrelic & newrelic_meetme_plugin
* Remove S3FS
* Update Gems
* Add Rakefile with lots of goodies
* Set up Test Kitchen
* Add ServerSpec tests
* Clean up APC attributes & DRY up `et_www::apc` recipe

v1.4.0 (2014-09-22)
-------------------

* Adjust Apache configs to allow for control via application-generated `.htaccess` files
* Remove deprecated Apache directives
* Adjust RewriteRules as needed for changes to URL structure

1.3.0
-----

* Update RewriteRules generated by W3TC WordPress plugin

1.2.0
-----

* Add clickjacking protection via Apache `Header` directive

1.1.5
-----

* Remove setting of CopperEgg attributes

1.1.4
-----

* Use more forward-thinking version constraints for apache2 & newrelic-ng cookbooks

1.1.3
-----

* Update Gemfile to have more sane versions
* Add Foodcritic & Rubocop
* Clean up code as per Rubocop

1.1.2
-----

* Clean up Berksfile to use Chef Server as The Truth

1.1.1
-----

* Use latest Test Kitchen & kitchen-vagrant

1.1.0
-----

* Remove `/apps` iOS distribution system
* Add CHANGELOG
