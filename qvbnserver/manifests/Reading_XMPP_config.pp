class qvbnserver::Reading_XMPP_config inherits qvbnserver {
    exec { "Reading_XMPP_config":
        command => "qvbn-rpc -a pretty walk qvbn-cmot-gateway",
        path    => "/usr/local/bin/:/bin/:/usr/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/",
      }
}