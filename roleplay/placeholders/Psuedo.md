<!SLIDE>
# Psuedo Puppet Code #
## I could be suggesting you use Rspec! ##

      @@@ Puppet
      class roles::build_server {
        #classses = hiera('roels::build_server::classes')
        classes = [
          'profiles::base',
          'profiles::build_server',
        ]

        notify{ ${classes}:
          message => "Inlcude ${title}",
        }

      }

Seriously I don't have 2 heads
~~~SECTION:notes~~~
notes for presenter mode
~~~ENDSECTION~~~

~~~SECTION:handouts~~~
this will be additional in print

~~~ENDSECTION~~~

