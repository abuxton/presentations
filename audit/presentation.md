autoscale: true 
footer: @digitaladept [http://abuxton.github.io]
slidenumbers: true
---
#Puppet Audit
###An alternative approach!
![right fit original](_images/hubot.png)

---
#Introductions
A need to support my coffee addiction has taken me around the world working with and supporting all manner of development teams. The same addiction has supported me through long days and nights of platform integrations, fire fighting and launch management for various development teams in startups, gaming, finance and most fields of enterprise.

Feel free to buy me a coffee and ask my opinion on anything technology, devops, or system architecture and  configuration management.

![right](../_shared/_images/me_fire_cmoss_e42014.jpg)

---
#Audit, what are we talking about?

* Auditing single states! in a controlled limited use.
* Currently, a meta parameter of all puppet resources.
* Flagged for deprecation due to its repeated abuse.
```
    file{'/path/to/a/folder':
      ensure => present,
      audit  => all,
      recurse => true,
    }
```


---
#[fit]Don't panic, you did not miss any thing!


* Why are we discussing replacing it?
* What about a its replacement?.
* How do you make use of the alternative.
* Gotchas!.


---
#WHY?
###Possible deprecation, but also a  new way of thinking.

> This was added for one customer and is no longer used or supported in PE. We should deprecate it.
-- Eric0
[https://tickets.puppetlabs.com/browse/PUP-893](https://tickets.puppetlabs.com/browse/PUP-893)

>You are maintaining concrete baselines in readable Puppet code, which can be audited via version control records
-- [https://docs.puppetlabs.com/pe/latest/compliance_alt.html](https://docs.puppetlabs.com/pe/latest/compliance_alt.html)

---
#Other considerations
###or excuse me!, we actually use it a lot!

Things we hear from various customers.

* But we want to use it?
* We need to ensure some compliance, or auditing?
* You published [https://docs.puppetlabs.com/pe/latest/compliance_alt.html](https://docs.puppetlabs.com/pe/latest/compliance_alt.html), but what does that mean in practice?

---
#What about it's replacement?
##Fulfilling a need

So we wrote a module to provide the some of the functionality, but it's a different approach thus it also has it's own implementation work flow.

* Why did we write a module?
* Why is this not under the Puppetlabs namespace?
* What's special about it? hint: nothing!
* Why did we do it this way?


---
#[fit]Logic behind the design

---
##Some whys and wherefores
**So why did we write a module?**
* Ease of delivery
**Why is this not under the Puppetlabs namespace?**
* The resource application is core code, it doe snot need to be a supported module!
**Why defined types and not Types and Providers?**
* We don't reinvent the wheel.
* Because it did not need them in this methodology!
**But what about supplying the checksum?**
* Puppet generally only cares about what you tell it, so this implementation makes sure you care.
> "With great power goes great responsibility" - Excelsior! 
> -- Stan Lee

---
#So what's under the hood?

```   
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
```
**Seriously thats all!** Use of an existing resource type **file**

---
#[fit]But what do you notice?

It breaks one rule, **its not unique**, it will cause **duplicate declaration**  errors!

---
#Audit as a Module
##What we left out?

We delivered this as a module, but the repository as some extras that you might like to explore.

```#tree ~/abuxton-puppet_audit
      ├─... normal module files and folders you know the ones!
      ├── hieradata
      │   ├── common.yaml
      │   └── global.yaml
      ├── manifests
      │   ├── directory.pp
      │   ├── file.pp
      │   ├── init.pp
      │   ├── link.pp
      │   └── params.pp
      ├── profiles
      │   └── puppet_audit.pp
      │   ├──
      └── tests
          ├── directory.pp
          ├── file.pp
          ├── filetest.pp
          ├── init.pp
          ├── link.pp
          └── puppet_audit.pp
          ...
```

---
#[fit]Making use of the Audit types
---
#Manifests code

```     puppet_audit::file { "/tmp/test":
          fileMD5 => "{md5}d41d8cd98f00b204e9800998ecf8427e",
          group   => "root",
          owner   => "root",
          mode    => "0777",
          tags    => "",
          }```

So what does it make you care about?

* All the things audit used to do by default, so these are over heads.
* Tags are not necessary, they are desirable for **reporting** and **orchestration** as its not always the implementors who care.

---
#Lightening the Load
So how do we lighten the load of managing audits? simple more Hiera.

* Gives us the ability to set the resource once, and then change the audit to known states. 
* Allows us to separate those who care about its state from the people implementing the puppet code.

---
#Providing Data with Hiera

```
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
```
---
#Building the resources from Hiera data
```
  # Setup local hash variables pulling data from Hiera hashes.

  $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
  $security_files_dafaults = hiera('profiles::puppet_audit_defaults',{})
  # Check files, directories, and links using create resources function.

  create_resources('puppet_audit::file', $security_files_hash,$security_files_defaults)
```
* The use of hiera_hash() function lets us pull the files from all levels of the hierarchy via the various logic switches and then generate the audits.
* We can even include a default set of parameters, these could be in Hiera too.

---
#Profiles
##how to decouple the overheads

* We can introduce the audit at any point in the Roles.
* Coupled with ordering or staging you can then, eliminate changes to those files by developers or highlight the requirement to audit those files.
* Use of inheritance can be made to pass the torch of ownership should you require it.

---
#Profile example

```
class profiles::puppet_audit {
  include puppet_audit

  # Setup local hash variables pulling data from Hiera hashes.
  $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
  $security_directories_hash = hiera_hash('profiles::puppet_audit_directories',{})
  $security_links_hash = hiera_hash('profiles::puppet_audit_links',{})

  # Check files, directories, and links using create resources function.
  create_resources('puppet_audit::file', $security_files_hash)
  create_resources('puppet_audit::directory', $security_directories_hash)
  create_resources('puppet_audit::link', $security_links_hash)
}
```

---
#GOTCHAs
##Things to bare in mind

So if you've not spotted them already I'm going to call them out!

* Duplicate resources, not only allowed but determined to hit them.
* Lots of front load on the requirement, thats right you have to generate the md5, know the desired group, owner and mode etc
* You'll need to communicate best practice for using them.
* The implementation could encourage inheritance of the profile for that a resource can be overridden, I'm not sure this is a bad thing, in this one case!


---
#Q&A


##Thats all folk, Thank you!
Its either time for some one else to bore you to sleep, or time to go to the bar!

---
#Credits
**links**

* [https://github.com/abuxton/puppet_audit](https://github.com/abuxton/puppet_audit)

**Images**

* [https://hubot.github.com/](https://hubot.github.com/)
* [http://charlottemoss.co.uk](http://charlottemoss.co.uk)

**Reference**

* [https://github.com/philsturgeon/dbad/blob/master/LICENSE-en.md](target="_blank">https://github.com/philsturgeon/dbad/blob/master/LICENSE-en.md)
