autoscale: true 
footer: @digitaladept [http://abuxton.github.io]
slidenumbers: true
---
#Puppet Audit
###A simple solution to deprecation!

---
#Introductions
A need to support my coffee addiction has taken me around the world working with and supporting all manner of development teams. The same addiction has supported me through long days and nights of platform integrations, fire fighting and launch management for various development teams in startups, gaming, finance and most fields of enterprise.

Feel free to buy me a coffee and ask my opinion on anything technology, devops, or system architecture and  configuration management.

---
#Audit, but its not gone any where!
###Don't panic, you did not miss any thing!###

The Puppet_audit module, a module that does nothing really special.
Although it does lets you keep a functionality you possibly not yet used, the audit metaparameter.

---
#Audit Metaparamter

```
    file{'/path/to/a/file':
      ensure => present,
      audit  => true,
    }
```
* Why did we need to?
* How did we choose to replace it?
* If you did use it you'll be glad we did!
* How do you make use of it?
* Gotchas!.

---
#WHY?
###Deprecating a feature, cut it, its not welcome any more!

> This was added for one customer and is no longer used or supported in PE. We should deprecate it.
-- Eric0


[https://tickets.puppetlabs.com/browse/PUP-893](https://tickets.puppetlabs.com/browse/PUP-893)

---
#What about a Replacement?

###Erm excuse me!, we actually use it alot!

But we want to use it?
* We need to ensure some compliance?
* You published <a href="https://docs.puppetlabs.com/pe/latest/compliance_alt.html" target="_blank">https://docs.puppetlabs.com/pe/latest/compliance_alt.html</a>, but what does that mean in practice?

---
#HOW?

#Motivation

##Purely fulfilling a want!

So we wrote a module to proviode the some of the former functionality.


* Why did we write a module?
* Why is this not under the Puppetlabs namespace?
* Whats special about it? hint: nothing!
* Why did we do it this way?


---
#[fit]Logic behind the design

---
##Some whys and wherefores

<p>So why did we write a module? </p>


* Delivery


Why defined types and not Types and Providers?


* We don't reinvent the wheel.
* Because we said do it like this.


But what about supplying the #hash.</p>

* Puppet only cares about what you do?
> "With great power goes great responsibility" - Excelsior!
--[http://en.wikiquote.org/wiki/Stan_Lee](http://en.wikiquote.org/wiki/Stan_Lee)

---
#So what's under the hud?

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
              ensure  =&gt; file,
              content =&gt; "${fileMD5}",
              group   =&gt; "${group}",
              mode    =&gt; "${mode}",
              owner   =&gt; "${owner}",
              noop    =&gt; true,
              replace =&gt; true,
            }
          }
          default:  {
          ...
```
**Seriously thats all!**

---
#But what do you notice?#
It breaks one rule, **its not unique**, it will cause #duplicate declaration#  errors!

---

#Audit as a Module

##What we left out of the package?

<p>We deliverd this as a module, but the repository as some extras that you might like to explore.</p>

<pre class="highlight"><code class="language-shell">    #tree ~/abuxton-puppet_audit
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
          ...```

---
#Making use of the Audit types
</div>
</div>
<div id="usage_manifest" class="slide " data-transition="none">
<div class="content " ref="usage/manifest">
#Manifests code

```     puppet_audit::file { "/tmp/test":
          fileMD5 =&gt; "{md5}d41d8cd98f00b204e9800998ecf8427e",
          group   =&gt; "root",
          owner   =&gt; "root",
          mode    =&gt; "0777",
          tags    =&gt; "",
          }```

<p>So what does it make you care about?</p>


* All the things audit used to do by default, so these are over heads.
* Tags are not necessery, they are desirable for reporting as its not always the implimentors who care.

---
#providing Data

##Auditing with Hiera

<pre class="highlight"><code class="language-shell">  ---
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
  hieradata/global.yaml ```

<p>So how do we lighten the load of managing audits? simple Hiera.</p>


* Gives us the ability to set the resource once, and then change the audit to known states. 
* Allows us to seperate those who care about its state from the peopel implimenting the puppetcode.

---

Create_resource

##building the resource from hiera data

<pre class="highlight"><code class="language-puppet">
  # Setup local hash variables pulling data from Hiera hashes.

  $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
  $security_files_dafaults = hiera('profiles::puppet_audit_defaults',{})
  # Check files, directories, and links using create resources function.

  create_resources('puppet_audit::file', $security_files_hash,$security_files_defaults)
}```


* The use of hiera hash fucntion lets us pull the files from all levels of the hierachy via the various logic switches and then generat the audits.
* We can even include a default set of parameters, these should be in hiera too.
---
Profiles

##how to decouple the obverheads

<pre class="highlight"><code class="language-puppet">class profiles::puppet_audit {
  include puppet_audit

  # Setup local hash variables pulling data from Hiera hashes.

  $security_files_hash = hiera_hash('profiles::puppet_audit_files',{})
  $security_directories_hash = hiera_hash('profiles::puppet_audit_directories',{})
  $security_links_hash = hiera_hash('profiles::puppet_audit_links',{})

  # Check files, directories, and links using create resources function.

  create_resources('puppet_audit::file', $security_files_hash)
  create_resources('puppet_audit::directory', $security_directories_hash)
  create_resources('puppet_audit::link', $security_links_hash)
}```


* We can introduce the audit at any point in the role.
* Coupled with ordering or staging you can then, eliminate changes to those files by developers or highlight teh requirment to audit those files.
---
GOTCHAs

##Things to bare in mind

<p>So if you've not spotted them already I'm going to call them out.</p>


* Duplicate resources, not only allowed but determined to hit them.
* Lots of front load on the requirment, thats right you have to generate the md5, know the desired group, owner and mode etc
* You'll need to comunicate best practice for using them.
* The implimentation could encourage inheritance of the profile o that a resource can be overridden, i'm not sure this is a bad thing?


---
##Thats all folks!

<p>Its either time for some one else to bore you to sleep, or time to go to the bar!</p>

---
#Credits

links
forge.puppetlabs.com/abuxton/puppet_audit
* <a href="https://github.com/abuxton/puppet_audit" target="_blank">https://github.com/abuxton/puppet_audit</a>
* <a href="https://github.com/abuxton/module_skeleton" target="_blank">https://github.com/abuxton/module_skeleton</a>


<h4>Images</h4>


* whatif.xkcd.com
* <a href="https://octodex.github.com/images/hubot.jpg" target="_blank">https://octodex.github.com/images/hubot.jpg</a>
* <a href="http://charlottemoss.co.uk" target="_blank">http://charlottemoss.co.uk</a>


<h4>Reference</h4>


* <a href="https://github.com/puppetlabs/showoff" target="_blank">https://github.com/puppetlabs/showoff</a>
* <a href="https://github.com/philsturgeon/dbad/blob/master/LICENSE-en.md" target="_blank">https://github.com/philsturgeon/dbad/blob/master/LICENSE-en.md

