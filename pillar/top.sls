{% import_yaml 'cluster/masters.sls' as mas %}
{% import_yaml 'cluster/network.sls' as net %}
{% import_yaml 'cluster/core.sls' as cor %}

base:
# Allowed to all hosts
  '*':
    - cluster/pkgs
    - cluster/services
{%- for types in cor.core.types %}
    - cluster/nodes/{{types}}
    - cluster/nodes/{{types}}_states
{%- endfor %}
    - cluster/io/nfs
    - cluster/network
    - cluster/masters
    - cluster/masters_states
    - engine/engine
    - cluster/core
    - cluster/authentication/ssh_public
    - cluster/authentication/passwords_public
    - cluster/authentication/ldap_public
    - engine/engine_monitoring
    - engine/engine_reverse
    - engine/engine_ip
    - cluster/monitoring
# Allowed to masters only, secure passwords and ssh private key
{% for master in mas.masters %}
  '{{master}}.{{net.network.net0.domaine_name}}':
    - cluster/authentication/ssh_private
    - cluster/authentication/ldap_private
{% endfor %}
