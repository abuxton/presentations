<!SLIDE>
# providing Data #
## Auditing with Hiera ##

      @@@ Shell
      ---
      'profiles::puppet_audit_files':
        '/etc/passwd':
          fileMD5: '{md5}0c4305ed79b2292299b00ebcb691a0e4'
          group: '0'
          mode: '644'
          owner: '0'
      'profiles::puppet_audit_directories':
        '/etc/rc.d':
          group: '0'
          owner: '0'
          mode: '755'
      'profiles::puppet_audit_links':
        '/etc/grub.conf':
          group: '0'
          owner: '0'
          mode: '777'
          target: '../boot/grub/grub.conf'
      hieradata/global.yaml 

So how do we lighten the load of managing audits? simple Hiera.

* Gives us the ability to set the resource once, and then change the audit to known states. 
* Allows us to seperate those who care about its state from the peopel implimenting the puppetcode.

~~~SECTION:notes~~~
notes for presenter mode
~~~ENDSECTION~~~

~~~SECTION:handouts~~~
this will be additional in print

~~~ENDSECTION~~~

