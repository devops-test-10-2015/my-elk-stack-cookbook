# my-elk-stack-cookbook

This cookbook will do a simple install of Logstash and Elastic Search on CentOS or RedHat.

It has been tested with CentOS 7.1.

## System set up

### Development and test envrionment set up

* Install [VirtualBox](https://www.virtualbox.org/)
* Install [Vagrant](https://docs.vagrantup.com/v2/)
* Install [ChefDK](https://downloads.chef.io/chef-dk/) for your platform
* Run the following commands:

    chef install
    kitchen test all

Once you have done that initial set up you can test any changes to the cookbook using these commands:

    kitchen converge
    kitchen verify

#### To add a dependency

* Add a `depends` to `metadata.rb`
* Run `chef update`
* Restart your test instance : `kitchen test`


## Key files

The key source files of interest are:

* `./recipes/default.rb` - the default recipe that does all the work
* `./attributes/default.rb` - some cookbook wide attributes

The main testing is done using serverspec and all the tests are in `./test/integration/default/serverspec/default_spec.rb`.

