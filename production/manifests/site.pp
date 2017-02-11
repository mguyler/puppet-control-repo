## site.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
# Global objects like filebuckets and resource defaults should go in this file,
# as should the default node definition. (The default node can be omitted
# if you use the console and don't define any other nodes in site.pp. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.)

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'main':
  server => 'puppet2-old.sdn-vz.net',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
}

#node 'picat1', 'dc1fb1', 'dc1fb2', 'dc2fb1', 'dc2fb2', 'dc3fb1', 'dc3fb2' {
#        include config
#}

#include '::ntp'

#class { '::ntp':
#	servers => [ '68.140.250.7', '68.140.250.8'],
#}


#class site::users{
#pe_accounts::user {'vz_operator':
#       comment => 'Verizon Operator',
#       password => 'BaxP9ifxYq9gI'
#}

#}


tidy {'/cftmp/':
        recurse => 'true',
        matches => "pica*.deb"
}


class hp5712_picos_714aa4e{

service { 'picos':
	ensure => 'running',
}


file { "/cftmp/pica-linux-2.7.1S3-HP5712-714aa4e.deb":
        mode =>'440',
        ensure => 'present',
        owner => 'root',
        group => 'root',
        source => "puppet:///modules/picaovs/pica-linux-2.7.1S3-HP5712-714aa4e.deb"
}
file { "/cftmp/pica-tools-2.7.1S3-HP5712-714aa4e.deb":
        mode =>'440',
        ensure => 'present',
        owner => 'root',
        group => 'root',
        source => "puppet:///modules/picaovs/pica-tools-2.7.1S3-HP5712-714aa4e.deb"
}
file { "/cftmp/pica-ovs-2.7.1S3-HP5712-714aa4e.deb":
        mode =>'440',
        ensure => 'present',
        owner => 'root',
        group => 'root',
        source => "puppet:///modules/picaovs/pica-ovs-2.7.1S3-HP5712-714aa4e.deb"
}

exec {'move picos_start.conf to picos_start.conf.bak':
	command => 'cp /etc/picos/picos_start.conf /etc/picos/picos_start.conf.bak',
	path    => '/usr/sbin:/usr/bin:/sbin:/bin',
}

package {'pica-linux-2.7.1S3-HP5712-714aa4e.deb':
        provider => dpkg,
        ensure => latest,
        source => "/cftmp/pica-linux-2.7.1S3-HP5712-714aa4e.deb"
}
package {'pica-tools-2.7.1S3-HP5712-714aa4e.deb':
        provider => dpkg,
        ensure => latest,
        source => "/cftmp/pica-tools-2.7.1S3-HP5712-714aa4e.deb"
}

exec { "move picos_start.conf.bak to picos_start.conf":
        command => 'cp /etc/picos/picos_start.conf.bak /etc/picos/picos_start.conf',
        path    => '/usr/sbin:/usr/bin:/sbin:/bin',
}

package {'pica-ovs-2.7.1S3-HP5712-714aa4e.deb':
        provider => dpkg,
        ensure => latest,
        source => "/cftmp/pica-ovs-2.7.1S3-HP5712-714aa4e.deb"
}

exec { 'Set TCAM Match Mode: 1-256 v6-full, 257-512 v6-64, 513-3328 v4':
	command => 'ovs-vsctl set-match-mode ipv6_full=1-256,ipv6_64=257-512,ipv4=513-3328',
	path    => '/usr/sbin:/usr/bin:/sbin:/bin:/ovs/bin:/ovs/sbin',
	notify  => Service['picos'],
}

exec { 'HW flow handling':
	command => 'ovs-vsctl set-flow-handling-mode hardware_flow_only',
	path    => '/usr/sbin:/usr/bin:/sbin:/bin:/ovs/bin:/ovs/sbin',
}
	

}


class hp5712_picos_a62177a{

service { 'picos':
	ensure => 'running',
}


file { "/cftmp/pica-linux-2.7.1S3-HP5712-a62177a.deb":
        mode =>'440',
        ensure => 'present',
        owner => 'root',
        group => 'root',
        source => "puppet:///modules/picaovs/pica-linux-2.7.1S3-HP5712-a62177a.deb"
}
file { "/cftmp/pica-tools-2.7.1S3-HP5712-a62177a.deb":
        mode =>'440',
        ensure => 'present',
        owner => 'root',
        group => 'root',
        source => "puppet:///modules/picaovs/pica-tools-2.7.1S3-HP5712-a62177a.deb"
}
file { "/cftmp/pica-ovs-2.7.1S3-HP5712-a62177a.deb":
        mode =>'440',
        ensure => 'present',
        owner => 'root',
        group => 'root',
        source => "puppet:///modules/picaovs/pica-ovs-2.7.1S3-HP5712-a62177a.deb"
}

exec {'move picos_start.conf to picos_start.conf.bak':
	command => 'cp /etc/picos/picos_start.conf /etc/picos/picos_start.conf.bak',
	path    => '/usr/sbin:/usr/bin:/sbin:/bin',
}

package {'pica-linux-2.7.1S3-HP5712-a62177a.deb':
        provider => dpkg,
        ensure => latest,
        source => "/cftmp/pica-linux-2.7.1S3-HP5712-a62177a.deb"
}
package {'pica-tools-2.7.1S3-HP5712-a62177a.deb':
        provider => dpkg,
        ensure => latest,
        source => "/cftmp/pica-tools-2.7.1S3-HP5712-a62177a.deb"
}

exec { "move picos_start.conf.bak to picos_start.conf":
        command => 'cp /etc/picos/picos_start.conf.bak /etc/picos/picos_start.conf',
        path    => '/usr/sbin:/usr/bin:/sbin:/bin',
}

package {'pica-ovs-2.7.1S3-HP5712-a62177a.deb':
        provider => dpkg,
        ensure => latest,
        source => "/cftmp/pica-ovs-2.7.1S3-HP5712-a62177a.deb"
}

exec { 'Set TCAM Match Mode: 1-256 v6-full, 257-512 v6-64, 513-3328 v4':
	command => 'ovs-vsctl set-match-mode ipv6_full=1-256,ipv6_64=257-512,ipv4=513-3328',
	path    => '/usr/sbin:/usr/bin:/sbin:/bin:/ovs/bin:/ovs/sbin',
	notify  => Service['picos'],
}

exec { 'HW flow handling':
	command => 'ovs-vsctl set-flow-handling-mode hardware_flow_only',
	path    => '/usr/sbin:/usr/bin:/sbin:/bin:/ovs/bin:/ovs/sbin',
}
	

}
