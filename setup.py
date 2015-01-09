#!usr/bin/python

import subprocess 
import shutil
import hashlib
import os
import inspect
import socket
 
class SetUp():
    
    def start_script(self):
        cur_dir=os.path.dirname(os.path.abspath(inspect.getfile(inspect.currentframe())))	
	p=subprocess.Popen("hostname -f",stdout=subprocess.PIPE,shell=True)
        out,err=p.communicate()
        with open(cur_dir + "/postinstall/postinstall") as old_file:
            lines=old_file.readlines()
        i=0
        for line in lines: 
            if line.startswith('server='):
                lines[i]='server=' + out 
                break
            i+=1
        with open(cur_dir + "/postinstall/postinstall","w") as new_file:
            new_file.writelines(lines)
       
        p=subprocess.Popen("facter | grep ipaddress_eth0",stdout=subprocess.PIPE,shell=True)
        out,err=p.communicate()
        ip_address=out.split("=>")[1].strip()	
        password=raw_input("Enter the passowrd: ")
        encrypted_pass=self.encrypt_pass(password)
        with open(cur_dir + "/preseed/preseed.seed") as file:
	    lines=file.readlines()
	i=0
	for line in lines:
	    if line.startswith("d-i live-installer/net-image"):
		lines[i]=line.split("//")[0]+ "//" + ip_address + line.split("//")[1][line.split("//")[1].find("/"):] 
	    if line.startswith("d-i mirror/http/hostname"):
		lines[i]=line.split("string")[0] + "string " + ip_address + "\n" 
	    if line.startswith('in-target /bin/sh -c "/usr/bin/curl -o /tmp/postinstall'):
		lines[i]=line.split("//")[0]+ "//" + ip_address + line.split("//")[1][line.split("//")[1].find("/"):]
            if line.startswith('in-target /bin/sh -c "/usr/bin/curl -o /etc/apt/sources.list'):
		lines[i]=line.split("//")[0]+ "//" + ip_address + line.split("//")[1][line.split("//")[1].find("/"):]
	    if line.startswith('d-i passwd/root-password-crypted password'):
		lines[i]="d-i passwd/root-password-crypted password " + encrypted_pass  + "\n"
	    i+=1
	with open(cur_dir + "/preseed/preseed.seed","w") as file:
		file.writelines(lines)
        while True:  
            xmpp_ip=raw_input("ENTER THE QVBB SERVER IP ADDRESS: ")
            if self.is_valid_ipv4_address(xmpp_ip):
                break
            print "Invalid IP address: Enter again"    
        with open(cur_dir + "/qvbnserver/manifests/xmpp_server_config.pp") as file:
            lines=file.readlines()
	i=0
	for line in lines:
	    if "command =>" in line:
                lines[i]=line.split("xmpp-server")[0] + "xmpp-server " + xmpp_ip + '",\n'
	    i+=1
        with open(cur_dir + "/qvbnserver/manifests/xmpp_server_config.pp","w") as file:
            file.writelines(lines)
        
        shutil.copyfile(cur_dir + "/postinstall/postinstall","/usr/share/foreman/public/postinstall")
        shutil.copyfile(cur_dir + "/preseed/preseed.seed","/usr/share/foreman/public/preseed.seed")
        shutil.copyfile(cur_dir + "/sources/sources.list","/usr/share/foreman/public/sources.list")
        shutil.copytree(cur_dir + "/qvbnserver" , "/etc/puppet/modules/qvbnserver")
	
    def is_valid_ipv4_address(self,address):
        try:
            socket.inet_pton(socket.AF_INET, address)
        except AttributeError:  # no inet_pton here, sorry
            try:
                socket.inet_aton(address)
            except socket.error:
                return False
            return address.count('.') == 3
        except socket.error:  # not a valid address
            return False
        return True

    def encrypt_pass(self,raw_password):
        salt = os.urandom(16)
	m = hashlib.md5()
	m.update(salt + raw_password)
	return m.hexdigest()

if __name__=="__main__":
    SetUp.start_script(SetUp())
