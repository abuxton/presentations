<!SLIDE>
# Code <snippet> #
## So what's under the hud?##

      @@@ Puppet
        define puppet_audit::file(
          $fileMD5,
          $group,
          $mode,
          $owner,
          $tags = '',
          $filepath = "${title}",
          ){
          case $tags{
              '': {

                file { "${filepath}" :
                  ensure  => file,
                  content => "${fileMD5}",
                  group   => "${group}",
                  mode    => "${mode}",
                  owner   => "${owner}",
                  noop    => true,
                  replace => true,
                }
              }
              default:  {
              ...
Seriously thats all!
### But what do you notice?
~~~SECTION:notes~~~
it breaks one rule, its not unique, it will cause duplicate declaration calls!
~~~ENDSECTION~~~

~~~SECTION:handouts~~~
this will be additional in print

~~~ENDSECTION~~~

