<!SLIDE>
# Manifests code #
## ##

      @@@puppet
          puppet_audit::file { "/tmp/test":
              fileMD5 => "{md5}d41d8cd98f00b204e9800998ecf8427e",
              group   => "root",
              owner   => "root",
              mode    => "0777",
              tags    => "",
              }

So what does it make you care about?

* All the things audit used to do by default, so these are over heads.
* Tags are not necessery, they are desirable for reporting as its not always the implimentors who care.


~~~SECTION:notes~~~
notes for presenter mode
~~~ENDSECTION~~~

~~~SECTION:handouts~~~
this will be additional in print

~~~ENDSECTION~~~

