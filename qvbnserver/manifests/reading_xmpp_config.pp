class qvbnserver::reading_xmpp_config inherits qvbnserver {
    exec { "reading_xmpp_config":
        command => "qvbn-rpc -a pretty walk qvbn-cmot-gateway",
        path    => "/usr/local/bin/:/bin/:/usr/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/",
      }
}