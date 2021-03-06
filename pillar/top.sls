{% import_yaml 'masters.sls' as mas %}
{% import_yaml 'network.sls' as net %}

base:
# Allowed to all hosts
  '*':
    - pkgs
    - services
    - computes
    - nfs
    - network
    - masters
    - logins
    - ios
    - engine
    - core
    - ssh_public
    - passwords_public
    - ldap_public
    - masters_states
    - computes_states
    - logins_states
    - ios_states
# Allowed to masters only, secure passwords and ssh private key
{% for master in mas.masters %}
  '{{master}}.{{net.network.domaine_name}}':
    - ssh_private
    - ldap_private
{% endfor %}
