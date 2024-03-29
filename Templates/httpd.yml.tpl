- hosts: ${vmHostname}
  tasks:
  - name: install the latest version of Apache
    yum:
      name: httpd
      state: latest

  - name: 
    service:
      name: httpd
      state: started 
      
  - name: install libselinux-python to enable ability to copy
    yum:
      name: libselinux-python
      state: present  

  - name: example copying file with owner and permissions
    copy:
      src: httpdfiles/index.html
      dest: /var/www/html
      owner: root
      group: root
      mode: 0644