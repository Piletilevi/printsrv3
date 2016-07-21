# -*- coding: utf-8 -*-

import urllib
import urllib2
import socket

def download_file(url,out_file_name,proxy)
    if(proxy!= None):
        proxy_support = urllib2.ProxyHandler({'http': proxy})
        opener = urllib2.build_opener(proxy_support)
        urllib2.install_opener(opener)

	try:
	    filein = urllib2.urlopen(url)
	except urllib2.URLError, msg:
		print "File download error error (%s)" % msg
		return False
	except socket.error, (errno, strerror):
		print "Socket error (%s) for host %s (%s)" % (errno, host, strerror)
		return False

	fileout = open(out_file_name, "wb")

	while True:
		try:
			bytes = filein.read(1024000)
			fileout.write(bytes)
		except IOError, (errno, strerror):
			print "I/O error(%s): %s" % (errno, strerror)
			return False
						 
		if bytes == "":
			break

	filein.close()
	fileout.close()
