<!SLIDE>
#Create_resource  #
## building the resource from hiera data##

    @@@ Puppet

      # Setup local hash variables pulling data from Hiera hashes.

      $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
      $security_files_dafaults = hiera('profiles::puppet_audit_defaults',{})
      # Check files, directories, and links using create resources function.

      create_resources('puppet_audit::file', $security_files_hash,$security_files_defaults)
    }

* The use of hiera hash fucntion lets us pull the files from all levels of the hierachy via the various logic switches and then generat the audits.
* We can even include a default set of parameters, these should be in hiera too.

~~~SECTION:notes~~~
notes for presenter mode
~~~ENDSECTION~~~

~~~SECTION:handouts~~~
this will be additional in print

~~~ENDSECTION~~~

