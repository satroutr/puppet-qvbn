class qvbnserver::xmpp_server_config inherits qvbnserver {
    exec { "xmpp_server_config":
        command => "qvbn-rpc -a pretty set qvbn-cmot-gateway tid cmot.gateway pubsub-node QVBN pubsub-server pubsub.localhost xmpp-server 10.77.94.243",
        path    => "/usr/local/bin/:/bin/:/usr/bin/:/usr/local/sbin/:/sbin/:/usr/sbin/",
      }
}
