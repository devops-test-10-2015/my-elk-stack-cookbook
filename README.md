# my-elk-stack-cookbook

## System set up

### Requirements

* You must be able to run docker without sudo to run the kitchen tests.

### Development and test set up

* Install ChefDK for your platform
* Run the following commands:
    bundle install
    chef install
    kitchen test all

Once you have done that initial set up you can test any changes to the cookbook using these commands:

    kitchen converge
    kitchen verify


#### To add a dependency

* Add a `depends` to `metadata.rb`
* Run `chef update`
* Restart your test instance : `kitchen test`

