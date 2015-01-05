class qvbnserver::guest_agentd_reload inherits qvbnserver {
    exec { "guest_agentd_reload":
        command => "service qvbn-guest-agentd reload",
        path    => "/usr/local/bin/:/bin/:/usr/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/:/etc/:/etc/init.d/",
      }
}

